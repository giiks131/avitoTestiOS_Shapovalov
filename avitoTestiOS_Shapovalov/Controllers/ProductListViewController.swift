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
    
    private let refreshControl = UIRefreshControl()
    private var activityIndicator: UIActivityIndicatorView!
    
    // ViewState property to manage UI states
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
        navigationItem.backButtonTitle = "Back"
        
        setupRetryButton()
        setupLoadingIndicator()
        setupCollectionView()
        fetchData()
    }
    
    private func setupRetryButton() {
        productListView.retryButton.addTarget(self, action: #selector(retryFetchingData), for: .touchUpInside)
    }
    
    @objc private func retryFetchingData() {
        fetchData()
    }
    
    private func setupLoadingIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    private func setupCollectionView() {
        productListView.collectionView.delegate = self
        productListView.collectionView.dataSource = self
        productListView.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        productListView.collectionView.refreshControl = refreshControl
    }
    
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
    
    // Function to update UI based on ViewState
    private func updateUI() {
        switch viewState {
        case .loading:
            activityIndicator.startAnimating()
            productListView.collectionView.isHidden = true
            productListView.errorLabel.isHidden = true
            productListView.retryButton.isHidden = true
        case .error:
            activityIndicator.stopAnimating()
            productListView.collectionView.isHidden = true
            productListView.errorLabel.isHidden = false
            productListView.retryButton.isHidden = false
        case .content:
            activityIndicator.stopAnimating()
            productListView.collectionView.isHidden = false
            productListView.errorLabel.isHidden = true
            productListView.retryButton.isHidden = true
            productListView.collectionView.reloadData()
        }
    }
}

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
        return CGSize(width: width, height: width * 2)
    }
}
