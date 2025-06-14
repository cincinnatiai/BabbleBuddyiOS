import Foundation
import UIKit
import Combine
import SwiftUI
import DesignKit

/// A view controller that displays a list of babies and manages user interaction.
/// Includes loading indicator, error handling, and navigation via a floating action button.
public class BabiesListView: UIViewController {

    // MARK: - Properties

    private var viewModel: BabiesListViewModel
    private var displayableBabies: [DisplayableBaby] = []
    private var subscription = [AnyCancellable]()
    private let localizedStrings = BabiesListLocalizedStringKeys.self

    // MARK: - UI Components

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

    // MARK: - Initialization

    /// Creates a new `BabiesListView` with a provided view model.
    /// - Parameter viewModel: The view model responsible for fetching and providing baby data.
    public init(viewModel: BabiesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(localizedStrings.FatalErrorMessage)
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupViewModel()
        observeViewModel()
        loadViewDesign()
        setupFloatingActionButton()
    }

    // MARK: - UI Setup

    /// Adds the table view and sets up constraints.
    func setupTableView() {
        view.addSubview(babiesTableView)
        setupConstraintsTableView()
    }

    /// Configures layout for the loader and adds it to the view.
    func loadViewDesign() {
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    /// Sets layout constraints for the table view.
    func setupConstraintsTableView() {
        NSLayoutConstraint.activate([
            babiesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            babiesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            babiesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            babiesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    // MARK: - ViewModel Binding

    /// Initializes the view model.
    func setupViewModel() {
        viewModel.initialize()
    }

    /// Observes state changes in the view model to update the UI accordingly.
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
                case .success(let babies):
                    display(babies: babies)
                    hideLoader()
                }
            }
            .store(in: &subscription)
    }

    /// Displays the given baby list in the table view.
    /// - Parameter babies: Array of babies to render.
    func display(babies: [DisplayableBaby]) {
        self.displayableBabies.append(contentsOf: babies)
        babiesTableView.reloadData()
    }

    // MARK: - Loader Handling

    /// Starts the loading spinner.
    func showLoader() {
        loader.startAnimating()
    }

    /// Stops the loading spinner.
    func hideLoader() {
        loader.stopAnimating()
    }

    // MARK: - Error Alert

    /// Shows an alert with the given error message.
    /// - Parameter errorMessage: The error description to show.
    func show(errorMessage: String) {
        let alertMessage = UIAlertController(
            title: localizedStrings.BabiesListViewAlertMessageTitle,
            message: errorMessage,
            preferredStyle: .alert
        )
        alertMessage.addAction(UIAlertAction(
            title: localizedStrings.BabiesListViewAlertActionLabel,
            style: .default
        ))
        present(alertMessage, animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension BabiesListView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayableBabies.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.tableViewCellIdentifier,
            for: indexPath
        ) as? BabyTableViewCell else {
            return UITableViewCell()
        }
        cell.configureInfo(with: displayableBabies[indexPath.row])
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Navigation with Floating Action Button
// TODO: Navigate to screen

extension BabiesListView {
    /// Adds the floating action button to the screen and configures its tap action.
    private func setupFloatingActionButton() {
        let fab = FloatingActionButton(
            iconName: "plus",
            accessibilityLabel: "Register new baby",
            action: { self.navigateToRegistration() }
        )

        let fabController = UIHostingController(rootView: fab)
        
        addChild(fabController)
        view.addSubview(fabController.view)
        
        fabController.didMove(toParent: self)
        fabController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fabController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            fabController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])
    }

    /// Navigates to a test registration view (needs to be adaoted to the one that will be used).
    private func navigateToRegistration() {
        let registrationVC = UIViewController()
        registrationVC.view.backgroundColor = .systemGroupedBackground
        registrationVC.title = "Test View"
        navigationController?.pushViewController(registrationVC, animated: true)
    }
}
