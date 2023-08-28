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

    override func loadView() {
        view = productDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Detail view loaded")
        fetchData()
    }

    private func fetchData() {
        guard let id = advertisementId else { return }
        Task {
            do {
                let advertisementDetail = try await NetworkManager.shared.fetchAdvertisementDetail(for: id)
                DispatchQueue.main.async {
                    self.configureUI(with: advertisementDetail)
                }
            } catch {
                print("Error fetching data: \(error)")
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
}

