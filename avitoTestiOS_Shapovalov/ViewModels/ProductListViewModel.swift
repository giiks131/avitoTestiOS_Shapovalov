//
//  ProductListViewModel.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

/// ViewModel responsible for managing the product list.
@MainActor
class ProductListViewModel {

    // MARK: - Properties

    /// Service for fetching advertisement data.
    private var advertisementService: AdvertisementService

    /// Array of advertisement models fetched from the service.
    private(set) var advertisements: [AdvertisementModel] = []

    /// Array of UI models derived from the advertisement models.
    private(set) var advertisementUIModels: [AdvertisementUIModel] = []

    /// Current state of the view.
    var viewState: ViewState = .loading {
        didSet {
            self.updateUIHandler?()
        }
    }

    /// Closure to trigger the UI update.
    var updateUIHandler: (() -> Void)?

    // MARK: - Initialization

    /// Initializes the ViewModel with an AdvertisementService.
    /// - Parameter advertisementService: The service for fetching advertisements.
    init(advertisementService: AdvertisementService) {
        self.advertisementService = advertisementService
    }

    // MARK: - Data Fetching

    /// Fetches the advertisement data.
    /// - Parameter completion: Optional completion handler.
    func fetchData(completion: @escaping () -> Void = {}) {
        viewState = .loading

        // Try to get data from cache first
        if let cachedData: [AdvertisementModel] = CacheManager.shared.get(key: "AdvertisementsCache", type: [AdvertisementModel].self) {
            self.advertisements = cachedData
            self.transformToUIModels()
            self.viewState = .content
            completion()
            return
        }

        Task {
            do {
                self.advertisements = try await advertisementService.fetchAdvertisements()
                self.transformToUIModels()
                self.viewState = .content

                // Save data to cache
                CacheManager.shared.set(key: "AdvertisementsCache", value: self.advertisements)
            } catch let error as NetworkError {
                self.viewState = .error(error)
            } catch {
                self.viewState = .error(NetworkError.decodingError)
            }
            completion()
        }
    }

    // MARK: - Helpers

    /// Transforms advertisement models to UI models.
    private func transformToUIModels() {
        self.advertisementUIModels = self.advertisements.map { AdvertisementUIModel(from: $0) }
    }
}
