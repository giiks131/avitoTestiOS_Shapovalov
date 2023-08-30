//
//  ProductDetailViewController.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

// A UIViewController subclass responsible for displaying the details of a single product.
class ProductDetailViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    var advertisementId: String?
    private let productDetailView = ProductDetailView()
    private var loadingView = LoadingView()
    
    // ViewState to handle UI state.
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

        setupNavigationBar()
        setupRetryButton()
        setupLoadingView()
        fetchData()
    }

    // MARK: - UI Setup
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
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

    // MARK: - Actions
    @objc func backButtonTapped() {
        // Perform the navigation back action or dismiss the view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func retryFetchingData() {
        fetchData()
    }

    // MARK: - Data Fetching
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
                    // Handle different types of errors.
                    if let networkError = error as? NetworkError {
                        // Handle specific network errors here. For future implementations
                    }
                    self.viewState = .error(error)
                }
            }
        }
    }

    // MARK: - UI Configuration
    private func configureUI(with model: AdvertisementDetailModel) {
        if let imageUrl = URL(string: model.imageUrl) {
            productDetailView.productImageView.loadImage(from: imageUrl, placeholder: UIImage(named: "placeholder")) {
                self.productDetailView.titleLabel.text = model.title
                self.productDetailView.priceLabel.text = model.price
                self.productDetailView.locationLabel.text = model.location
                self.productDetailView.descriptionText.text = model.description
                self.productDetailView.emailLabel.text = model.email
                self.productDetailView.phoneNumberLabel.text = model.phoneNumber
                self.productDetailView.addressLabel.text = model.address

                if let formattedDate = DateFormatterUtility.formatDate(from: model.createdDate, fromFormat: "yyyy-MM-dd", toFormat: "dd MMMM yyyy") {
                    self.productDetailView.createdDateLabel.text = formattedDate
                }
            }
        }
    }
    
    private func updateUI() {
        switch viewState {
        case .loading:
            setProductDetailViewAlpha(to: 0) // Make ProductDetailView's subviews transparent
            loadingView.showLoading()
            view.bringSubviewToFront(loadingView)
        case .error:
            setProductDetailViewAlpha(to: 0) // Make ProductDetailView's subviews transparent
            loadingView.showError()
            view.bringSubviewToFront(loadingView)
        case .content:
            setProductDetailViewAlpha(to: 1) // Make ProductDetailView's subviews opaque
            loadingView.hide()
        }
    }

    private func setProductDetailViewAlpha(to alpha: CGFloat) {
        productDetailView.scrollView.alpha = alpha
    }
}

