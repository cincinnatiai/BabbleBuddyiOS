import Foundation
import UIKit
import Combine
import SwiftUI
import DesignKit
import SettingsModule

/// A view controller that displays a list of babies and manages user interaction.
/// Includes loading indicator, error handling, and navigation via a floating action button.
public class BabiesListView: UIViewController {

    // MARK: - Properties

    private var viewModel: BabiesListViewModel
    private var displayableBabies: [DisplayableBabyItem] = []
    private var subscription = [AnyCancellable]()
    private let onAddBabyTapped: ( UINavigationController ) -> Void
    private let onEditBabbyTapped: (UINavigationController, BabyCardDisplayModel) -> Void
    private var localizedStrings: BabiesListLocalizedStringKeys.Type {
        return BabiesListLocalizedStringKeys.self
    }

    // MARK: - UI Components

    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .large
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()

    private lazy var babyListView: BBGenericListBuilder<BabyCardDisplayModel, BabyTableViewCell> = {
        let view = BBGenericListBuilder<BabyCardDisplayModel, BabyTableViewCell>()
        view.configureCell = { cell, baby in
            cell.configure(with: baby) {
                if let nav = self.navigationController {
                    self.onEditBabbyTapped(nav, baby)
                }
            } onDelete: {
                self.showDeleteConfirmation(for: baby)
            }
        }
        view.didSelectItem = { baby in
            // TODO: Navigate to details screen
        }
        return view
    }()


    // MARK: - Initialization

    /// Creates a new `BabiesListView` with a provided view model.
    /// - Parameter viewModel: The view model responsible for fetching and providing baby data.
    public init(
        viewModel: BabiesListViewModel,
        onAddBabyTapped: @escaping ( UINavigationController ) -> Void,
        onEditBabbyTapped: @escaping (UINavigationController, BabyCardDisplayModel) -> Void
    ) {
        self.viewModel = viewModel
        self.onAddBabyTapped = onAddBabyTapped
        self.onEditBabbyTapped = onEditBabbyTapped
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(BabiesListLocalizedStringKeys.FatalErrorMessage)
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(languageDidChange(_:)),
            name: .languageDidChange,
            object: nil
        )
        title = localizedStrings.BabyListViewScreenTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }

    // MARK: - UI Setup

    /// Adds the table view and sets up constraints.
    func setupTableView() {
        view.addSubview(babyListView)
        babyListView.translatesAutoresizingMaskIntoConstraints = false
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
            babyListView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            babyListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            babyListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            babyListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
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
            .receive(on: DispatchQueue.main)
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
    func display(babies: [BabyCardDisplayModel]) {
        babyListView.items = babies
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

    @objc func languageDidChange(_ notification: Notification) {
        title = localizedStrings.BabyListViewScreenTitle
    }
    
    private func showDeleteConfirmation(for baby: BabyCardDisplayModel) {
        let alert = UIAlertController(
            title: localizedStrings.BabyListViewAlertDeleteTitle,
            message: "\(localizedStrings.BabyListViewAlertDeleteMessage) \(baby.baby.title)?",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: localizedStrings.BabyListViewAlertDeleteCancel,
                style: .cancel,
                handler: nil
            )
        )
        alert.addAction(
            UIAlertAction(
                title: localizedStrings.BabyListViewAlertDelete,
                style: .destructive,
                handler: { [weak self] _ in
                    self?.deleteBaby(baby)
                }
            )
        )
        present(alert, animated: true)
    }

    private func deleteBaby(_ baby: BabyCardDisplayModel) {
        viewModel.deleteBaby(baby: baby) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    if success {
                        self.showMessage(self.localizedStrings.BabyListViewAlertDeleteDeleting)
                    } else {
                        self.showMessage(self.localizedStrings.BabyListViewAlertDeleteError)
                    }
                case .failure(let error):
                    self.showMessage("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func showMessage(_ message: String) {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Navigation with Floating Action Button

extension BabiesListView {
    /// Adds the floating action button to the screen and configures its tap action.
    private func setupFloatingActionButton() {
        guard let nav = self.navigationController else { return }

        let fab = BBFloatingActionButton(
            iconName: "plus",
            accessibilityLabel: "Register new baby",
            action: { self.onAddBabyTapped(nav) }
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
}
