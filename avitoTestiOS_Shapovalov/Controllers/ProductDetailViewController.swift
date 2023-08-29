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

        productDetailView.retryButton.addTarget(self, action: #selector(retryFetchingData), for: .touchUpInside)
        fetchData()
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
        productDetailView.titleLabel.text = model.title
        productDetailView.priceLabel.text = model.price
        productDetailView.locationLabel.text = model.location
        productDetailView.descriptionLabel.text = model.description
        productDetailView.emailLabel.text = model.email
        productDetailView.phoneNumberLabel.text = model.phone_number
        productDetailView.addressLabel.text = model.address

        if let imageUrl = URL(string: model.image_url) {
            productDetailView.productImageView.loadImage(from: imageUrl, placeholder: UIImage(named: "placeholder"))
        }
    }

    private func updateUI() {
        switch viewState {
               case .loading:
                   productDetailView.activityIndicator.startAnimating()
                   productDetailView.errorLabel.isHidden = true
                   productDetailView.retryButton.isHidden = true
               case .error:
                   productDetailView.activityIndicator.stopAnimating()
                   productDetailView.errorLabel.isHidden = false
                   productDetailView.retryButton.isHidden = false
               case .content:
                   productDetailView.activityIndicator.stopAnimating()
                   productDetailView.errorLabel.isHidden = true
                   productDetailView.retryButton.isHidden = true
            }
        }
}

