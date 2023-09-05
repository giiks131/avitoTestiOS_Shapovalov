//
//  ProductListViewModel.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

@MainActor
class ProductListViewModel {
    private var advertisementService: AdvertisementService
    private(set) var advertisements: [AdvertisementModel] = []
    private(set) var advertisementUIModels: [AdvertisementUIModel] = []

    var viewState: ViewState = .loading {
        didSet {
            self.updateUIHandler?()
        }
    }

    var updateUIHandler: (() -> Void)?

    init(advertisementService: AdvertisementService) {
        self.advertisementService = advertisementService
    }

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
            } catch {
                self.viewState = .error(error)
            }
            completion()
        }
    }

    private func transformToUIModels() {
        self.advertisementUIModels = self.advertisements.map { AdvertisementUIModel(from: $0) }
    }
}
