//
//  ProductListViewModel.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

class ProductListViewModel {
    
    private var advertisementService: AdvertisementService
    private(set) var advertisements: [AdvertisementModel] = []
    
    var viewState: ViewState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.updateUIHandler?()
            }
        }
    }
    
    var updateUIHandler: (() -> Void)?
    
    init(advertisementService: AdvertisementService) {
        self.advertisementService = advertisementService
    }
    
    func fetchData(completion: @escaping () -> Void = {}) {
        viewState = .loading
        Task {
            do {
                self.advertisements = try await advertisementService.fetchAdvertisements()
                self.viewState = .content
            } catch {
                self.viewState = .error(error)
            }
            completion()
        }
    }
}
