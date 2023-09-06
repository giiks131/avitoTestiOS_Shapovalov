//
//  ProductDetailViewModel.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

/// ViewModel responsible for managing the product details.
@MainActor
class ProductDetailViewModel {

    // MARK: - Properties

    /// Service for fetching advertisement detail data.
    private var detailService: DetailService

    /// Model containing the advertisement detail.
    private(set) var advertisementDetail: AdvertisementDetailModel?

    /// UI model derived from the advertisement detail model.
    private(set) var advertisementDetailUIModel: AdvertisementDetailUIModel?

    /// ID of the advertisement for fetching its details.
    var advertisementId: String

    /// Current state of the view.
    var viewState: ViewState = .loading {
        didSet {
            self.updateUIHandler?()
        }
    }

    /// Closure to trigger the UI update.
    var updateUIHandler: (() -> Void)?

    // MARK: - Initialization

    /// Initializes the ViewModel with a DetailService and an advertisement ID.
    /// - Parameters:
    ///   - detailService: The service for fetching advertisement details.
    ///   - advertisementId: The ID of the advertisement.
    init(detailService: DetailService, advertisementId: String) {
        self.detailService = detailService
        self.advertisementId = advertisementId
    }

    // MARK: - Data Fetching

    /// Fetches the advertisement details.
    func fetchData() {
        viewState = .loading

        Task {
            do {
                let detail = try await detailService.fetchAdvertisementDetail(for: advertisementId)
                self.advertisementDetail = detail
                self.transformToUIModel()
                self.viewState = .content
            } catch let error as NetworkError {
                self.viewState = .error(error)
            } catch {
                self.viewState = .error(NetworkError.decodingError)
            }
        }
    }

    // MARK: - Helpers

    /// Transforms the advertisement detail to a UI model.
    private func transformToUIModel() {
        if let detail = self.advertisementDetail {
            self.advertisementDetailUIModel = AdvertisementDetailUIModel(from: detail)
        }
    }
}
