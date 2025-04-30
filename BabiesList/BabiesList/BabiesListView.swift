//
//  BabiesList.swift
//  BabiesList
//
//  Created by Trainee on 4/18/25.
//

import Foundation
import UIKit
import Combine

public class BabiesListView: UIViewController {
    private var viewModel: BabiesListViewModel
    private var displayableBabies: [DisplayableBaby] = []
    
    private var subscription = [AnyCancellable]()
    private let localizedStrings = BabiesListLocalizedStringKeys.self
    
    private lazy var babiesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BabyTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        return tableView
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .large
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    public init(viewModel: BabiesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(localizedStrings.FatalErrorMessage)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupViewModel()
        observeViewModel()
        loadViewDesign()
    }
    
    func setupTableView() {
        view.addSubview(babiesTableView)
        setupConstraintsTableView()
    }
    
    func setupViewModel() {
        viewModel.initialize()
    }
    
    func loadViewDesign() {
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupConstraintsTableView() {
        NSLayoutConstraint.activate([
            babiesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            babiesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            babiesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            babiesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func observeViewModel() {
        viewModel.$babiesState
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .loading:
                    showLoader()
                case .error(let error):
                    show(errorMessage: error)
                    hideLoader()
                case .success(let babies): display(babies: babies)
                    hideLoader()
                }
            }
            .store(in: &subscription)
    }
    
    func display(babies: [DisplayableBaby]) {
        self.displayableBabies.append(contentsOf: babies)
        babiesTableView.reloadData()
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.stopAnimating()
    }
    
    func show(errorMessage: String) {
        let alertMessage = UIAlertController(title: localizedStrings.BabiesListViewAlertMessageTitle,message: errorMessage, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: localizedStrings.BabiesListViewAlertActionLabel, style: .default ))
        present(alertMessage, animated: true)
    }
}

extension BabiesListView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayableBabies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as? BabyTableViewCell else {
            return UITableViewCell()
        }
        cell.configureInfo(with: displayableBabies[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
