//
//  ProductDetailViewModel.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

@MainActor
class ProductDetailViewModel {
    private var detailService: DetailService
    private(set) var advertisementDetail: AdvertisementDetailModel?
    private(set) var advertisementDetailUIModel: AdvertisementDetailUIModel?
    
    var advertisementId: String
    
    var viewState: ViewState = .loading {
        didSet {
            self.updateUIHandler?()
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
                self.advertisementDetail = detail
                self.viewState = .content
            } catch {
                self.viewState = .error(error)
            }
        }
    }
}
