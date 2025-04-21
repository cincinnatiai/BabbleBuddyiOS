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
    private var babiesDisplayer: UITableView = UITableView(frame: .zero)
    private var displayablebabies: [DisplayableBaby] = []
    private var loader: UIActivityIndicatorView = UIActivityIndicatorView()
    private var subscription = [AnyCancellable]()
    private let localizedStrings = BabiesListLocalizedStringKeys.self

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
        setupCastDisplayer()
        setupViewModel()
        babiesDisplayer.dataSource = self
        babiesDisplayer.delegate = self
        babiesDisplayer.translatesAutoresizingMaskIntoConstraints = false
        observeViewModel()
        loadViewDesign()
    }
}

private extension BabiesListView {
    func setupCastDisplayer() {
        babiesDisplayer.register(BabyTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        view.addSubview(babiesDisplayer)
        setupConstraintsTableView()
    }

    func setupViewModel() {
        viewModel.initialize()
    }

    func loadViewDesign() {
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.center = view.center
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        loader.hidesWhenStopped = true
    }

    func setupConstraintsTableView() {
        NSLayoutConstraint.activate([
            babiesDisplayer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            babiesDisplayer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            babiesDisplayer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            babiesDisplayer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension BabiesListView {

    func observeViewModel() {
        viewModel.$babiesState.sink { [weak self] state in
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
        self.displayablebabies.append(contentsOf: babies)
        babiesDisplayer.reloadData()
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
        return displayablebabies.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as? BabyTableViewCell else {
            return UITableViewCell()
        }
        cell.configureInfo(with: displayablebabies[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBaby = displayablebabies[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
    }
}
