//
//  BabyListView.swift
//  babiesList
//
//  Created by Trainee on 4/8/25.
//

import Foundation
import UIKit
import Combine

public class BabyListView: UIViewController {
    private var viewModel: BabyListViewModel
    private var babiesDisplayer: UITableView = UITableView(frame: .zero)
    private var displayablebabies: [DisplayableBaby] = []
    private var loader: UIActivityIndicatorView = UIActivityIndicatorView()
    private var subscription = [AnyCancellable]()

   public init(viewModel: BabyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCastDisplayer()
        setupViewModel()
        babiesDisplayer.dataSource = self
        babiesDisplayer.delegate = self
        babiesDisplayer.translatesAutoresizingMaskIntoConstraints = false
        observeViewModel()
        loadViewDesign()
    }
}

private extension BabyListView {
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

    private enum Constants {
        static let tableViewCellIdentifier = "BabyTableViewCell"
    }
}

extension BabyListView {

    func observeViewModel() {
        viewModel.$babiesState.sink { [weak self] state in
            guard let self else { return }
            switch state {
            case .loading:
                showLoader()
            case .error(let error):
                show(errorMessage: error)
                hideLoader()
            case .success(let pokemons): display(cast: pokemons)
                hideLoader()
            }
        }
        .store(in: &subscription)
    }

    func display(cast: [DisplayableBaby]) {
        self.displayablebabies.append(contentsOf: cast)
        babiesDisplayer.reloadData()
    }

    func showLoader() {
        loader.startAnimating()
    }

    func hideLoader() {
        loader.stopAnimating()
    }

    func show(errorMessage: String) {
        let alertMessage = UIAlertController(title: "Error ",message: errorMessage, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style: .default ))
        present(alertMessage, animated: true)
    }
}

extension BabyListView: UITableViewDataSource, UITableViewDelegate {
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
        // TODO: Action after click on one element
            tableView.deselectRow(at: indexPath, animated: true)
    }
}

fileprivate extension UITableViewCell {
    static var identifier: String {
        "cell_identifier"
    }
}
