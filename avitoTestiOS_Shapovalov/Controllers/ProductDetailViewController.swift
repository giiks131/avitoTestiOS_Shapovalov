//
//  ProductDetailViewController.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

/// A UIViewController subclass for displaying the details of a product.
class ProductDetailViewController: UIViewController {

    // MARK: - Properties

    /// Coordinator for navigation.
    var coordinator: MainCoordinator?

    /// Custom view for displaying the product details.
    private let productDetailView = ProductDetailView()

    /// Custom view for loading and error states.
    private var loadingView = LoadingView()

    /// ViewModel for handling business logic.
    private let viewModel: ProductDetailViewModel

    // MARK: - Initialization

    /// Initializes a new ProductDetailViewController.
    /// - Parameter viewModel: The ViewModel to use.
    init(viewModel: ProductDetailViewModel) {
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
        view = productDetailView
    }

    /// Configures the view after loading.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Подробности о товаре"

        setupLoadingView()
        setupRetryButton()

        // Update UI when ViewModel triggers it
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

    // MARK: - UI Update

    /// Updates the UI based on the ViewModel's state.
    private func updateUI() {
        switch viewModel.viewState {
        case .loading:
            setProductDetailViewAlpha(to: 0)
            loadingView.showLoading()
            view.bringSubviewToFront(loadingView)
        case .error(let error):
            setProductDetailViewAlpha(to: 0)
            loadingView.showError(error)
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

    /// Sets the alpha value for the product detail view.
    /// - Parameter alpha: The alpha value.
    private func setProductDetailViewAlpha(to alpha: CGFloat) {
        productDetailView.scrollView.alpha = alpha
    }

    /// Configures the UI elements with the given model.
    /// - Parameter model: The model containing the data.
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
