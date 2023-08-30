//
//  ProductDetailViewController.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    var advertisementId: String?
    private let productDetailView = ProductDetailView()
    private var loadingView = LoadingView()
    
    private var viewState: ViewState = .loading {
        didSet {
            updateUI()
        }
    }
    
    override func loadView() {
        view = productDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Detail view loaded")
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        setupRetryButton()
        setupLoadingView()
        fetchData()
    }
    
    private func setupRetryButton() {
        loadingView.retryButton.addTarget(self, action: #selector(retryFetchingData), for: .touchUpInside)
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
    
    
    @objc func backButtonTapped() {
        // Perform the navigation back action or dismiss the view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func retryFetchingData() {
        fetchData()
    }
    
    private func fetchData() {
        guard let id = advertisementId else { return }
        viewState = .loading
        Task {
            do {
                let advertisementDetail = try await NetworkManager.shared.fetchAdvertisementDetail(for: id)
                DispatchQueue.main.async {
                    self.configureUI(with: advertisementDetail)
                    self.viewState = .content
                }
            } catch {
                DispatchQueue.main.async {
                    self.viewState = .error(error)
                }
            }
        }
    }
    
    private func configureUI(with model: AdvertisementDetailModel) {
        if let imageUrl = URL(string: model.image_url) {
            productDetailView.productImageView.loadImage(from: imageUrl, placeholder: UIImage(named: "placeholder")) {
                self.productDetailView.titleLabel.text = model.title
                self.productDetailView.priceLabel.text = model.price
                self.productDetailView.locationLabel.text = model.location
                self.productDetailView.descriptionText.text = model.description
                self.productDetailView.emailLabel.text = model.email
                self.productDetailView.phoneNumberLabel.text = model.phone_number
                self.productDetailView.addressLabel.text = model.address
            }
        }
    }
    
    
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
        }
    }
    
}

