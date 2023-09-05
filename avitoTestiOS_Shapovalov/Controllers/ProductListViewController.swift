//
//  ProductListViewController.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    private let productListView = ProductListView()
    private var loadingView = LoadingView()
    private let refreshControl = UIRefreshControl()
    private let viewModel: ProductListViewModel
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = productListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Advertisements"
        
        setupLoadingView()
        setupRetryButton()
        setupCollectionView()
        
        viewModel.updateUIHandler = { [weak self] in
            self?.updateUI()
        }
        
        viewModel.fetchData()
    }
    
    private func setupRetryButton() {
        loadingView.retryButton.addTarget(self, action: #selector(retryFetchingData), for: .touchUpInside)
    }
    
    @objc private func retryFetchingData() {
        viewModel.fetchData()
    }
    
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
    
    private func setupCollectionView() {
        productListView.collectionView.delegate = self
        productListView.collectionView.dataSource = self
        productListView.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)

        let layout = createCompositionalLayout()
        productListView.collectionView.collectionViewLayout = layout

        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        productListView.collectionView.refreshControl = refreshControl
    }

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
    
    @objc private func reloadData() {
        viewModel.fetchData { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }

    
    private func updateUI() {
        switch viewModel.viewState {
        case .loading:
            loadingView.showLoading()
            view.bringSubviewToFront(loadingView)
        case .error:
            loadingView.showError()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.advertisements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        let advertisement = viewModel.advertisements[indexPath.row]
        cell.configure(with: advertisement)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAdvertisement = viewModel.advertisements[indexPath.row]
        coordinator?.navigateToProductDetail(with: selectedAdvertisement.id)
    }
}
