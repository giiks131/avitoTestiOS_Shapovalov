//
//  ProductListViewController.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

/// A UIViewController subclass for displaying the list of products.
class ProductListViewController: UIViewController {

    // MARK: - Properties

    /// Coordinator for navigation.
    var coordinator: MainCoordinator?

    /// Custom view for displaying the product list.
    private let productListView = ProductListView()

    /// Custom view for loading and error states.
    private var loadingView = LoadingView()

    /// UIRefreshControl for pull-to-refresh functionality.
    private let refreshControl = UIRefreshControl()

    /// ViewModel for handling business logic.
    private let viewModel: ProductListViewModel

    // MARK: - Initialization

    /// Initializes a new ProductListViewController.
    /// - Parameter viewModel: The ViewModel to use.
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    /// Required initializer, not implemented.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods

    /// Sets up the view hierarchy and layout.
    override func loadView() {
        view = productListView
    }

    /// Configures the view after loading.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Объявления"

        setupLoadingView()
        setupRetryButton()
        setupCollectionView()

        viewModel.updateUIHandler = { [weak self] in
            self?.updateUI()
        }

        viewModel.fetchData()
    }

    // MARK: - Setup Methods

    /// Sets up the loading view.
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    /// Sets up the retry button's action.
    private func setupRetryButton() {
        loadingView.retryButton.addTarget(self, action: #selector(retryFetchingData), for: .touchUpInside)
    }

    /// Fetches data again after a retry action.
    @objc private func retryFetchingData() {
        viewModel.fetchData()
    }

    /// Sets up the collection view.
    private func setupCollectionView() {
        productListView.collectionView.delegate = self
        productListView.collectionView.dataSource = self
        productListView.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)

        let layout = createCompositionalLayout()
        productListView.collectionView.collectionViewLayout = layout

        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        productListView.collectionView.refreshControl = refreshControl
    }

    /// Creates a compositional layout for the collection view.
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.interGroupSpacing = 10

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    /// Reloads the data when the refresh control is activated.
    @objc private func reloadData() {
        viewModel.fetchData { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }

    /// Updates the UI based on the ViewModel's state.
    private func updateUI() {
        switch viewModel.viewState {
        case .loading:
            loadingView.showLoading()
            view.bringSubviewToFront(loadingView)
        case .error(let error):
            loadingView.showError(error)
            view.bringSubviewToFront(loadingView)
        case .content:
            loadingView.hide()
            view.sendSubviewToBack(loadingView)
            productListView.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate & Data Source

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    /// Returns the number of items to display in a given section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.advertisementUIModels.count
    }

    /// Returns a configured cell for a given index path.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        cell.prepareForReuse()
        let advertisement = viewModel.advertisementUIModels[indexPath.row]
        Task {
            await cell.configure(with: advertisement)
        }
        return cell
    }

    /// Handles cell selection to navigate to product details.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAdvertisement = viewModel.advertisementUIModels[indexPath.row]
        coordinator?.navigateToProductDetail(with: selectedAdvertisement.id)
    }
}
