//
//  ProductDetailViewModel.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

class ProductDetailViewModel {
    private var detailService: DetailService
    private(set) var advertisementDetail: AdvertisementDetailModel?

    var advertisementId: String

    var viewState: ViewState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.updateUIHandler?()
            }
        }
    }

    var updateUIHandler: (() -> Void)?

    init(detailService: DetailService, advertisementId: String) {
        self.detailService = detailService
        self.advertisementId = advertisementId
    }

    func fetchData() {
        viewState = .loading
        Task {
            do {
                let detail = try await detailService.fetchAdvertisementDetail(for: advertisementId)
                DispatchQueue.main.async {
                    self.advertisementDetail = detail
                    self.viewState = .content
                }
            } catch {
                DispatchQueue.main.async {
                    self.viewState = .error(error)
                }
            }
        }
    }
}
