//
//  ProductListViewController.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class ProductListViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    private var advertisements: [AdvertisementModel] = []
    private let productListView = ProductListView()
    
    private var loadingView = LoadingView()
    
    private let refreshControl = UIRefreshControl()
    
    // Property to manage UI states
    private var viewState: ViewState = .loading {
        didSet {
            updateUI()
        }
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
        fetchData()
    }

    // MARK: - Setup Methods
    private func setupRetryButton() {
        loadingView.retryButton.addTarget(self, action: #selector(retryFetchingData), for: .touchUpInside)
    }
    
    @objc private func retryFetchingData() {
        fetchData()
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
        loadingView.isUserInteractionEnabled = true
    }
    
    private func setupCollectionView() {
        productListView.collectionView.delegate = self
        productListView.collectionView.dataSource = self
        productListView.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        productListView.collectionView.refreshControl = refreshControl
    }

    // MARK: - Data Fetching
    @objc private func reloadData() {
        fetchData { success in
            self.refreshControl.endRefreshing()
        }
    }
    
    private func fetchData(completion: ((Bool) -> Void)? = nil) {
        viewState = .loading
        Task {
            do {
                self.advertisements = try await NetworkManager.shared.fetchAdvertisements()
                DispatchQueue.main.async {
                    self.viewState = .content
                    completion?(true)
                }
            } catch {
                DispatchQueue.main.async {
                    self.viewState = .error(error)
                    completion?(false)
                }
            }
        }
    }
    
    // MARK: - UI Update
    private func updateUI() {
        switch viewState {
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
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        let advertisement = advertisements[indexPath.row]
        cell.configure(with: advertisement)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let coordinator = coordinator {
            let selectedAdvertisement = advertisements[indexPath.row]
            coordinator.navigateToProductDetail(with: selectedAdvertisement.id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 8) / 2
        return CGSize(width: width, height: width * 1.75)
    }
}
