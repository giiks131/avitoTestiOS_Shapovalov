//
//  ProductDetailViewController.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    private let productDetailView = ProductDetailView()
    private var loadingView = LoadingView()
    private let viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = productDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Подробности о товаре"
        setupLoadingView()
        setupRetryButton()
        
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
    
    // MARK: - UI Update
    
    private func updateUI() {
        switch viewModel.viewState {
        case .loading:
            setProductDetailViewAlpha(to: 0)
            loadingView.showLoading()
            view.bringSubviewToFront(loadingView)
        case .error:
            setProductDetailViewAlpha(to: 0)
            loadingView.showError()
            view.bringSubviewToFront(loadingView)
        case .content:
            setProductDetailViewAlpha(to: 1)
            loadingView.hide()
            if let detail = viewModel.advertisementDetailUIModel {
                Task {
                    await configureUI(with: detail)
                }
            }
        }
    }
    
    private func setProductDetailViewAlpha(to alpha: CGFloat) {
        productDetailView.scrollView.alpha = alpha
    }
    
    private func configureUI(with model: AdvertisementDetailUIModel) async {
        await productDetailView.productImageView.loadImage(from: model.imageUrl, placeholder: UIImage(named: "placeholder"))
        self.productDetailView.titleLabel.text = model.title
        self.productDetailView.priceLabel.text = model.price
        self.productDetailView.locationLabel.text = model.location
        self.productDetailView.descriptionText.text = model.description
        self.productDetailView.emailLabel.text = model.email
        self.productDetailView.phoneNumberLabel.text = model.phoneNumber
        self.productDetailView.addressLabel.text = model.address
        self.productDetailView.createdDateLabel.text = model.createdDate
    }
}
