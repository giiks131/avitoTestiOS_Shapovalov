//
//  MockAdvertisementService.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation
@testable import avitoTestiOS_Shapovalov

class MockAdvertisementService: AdvertisementFetchable {
    var shouldReturnError: Bool
    var mockAdvertisements: [AdvertisementModel]

    init(shouldReturnError: Bool = false, mockAdvertisements: [AdvertisementModel] = []) {
        self.shouldReturnError = shouldReturnError
        self.mockAdvertisements = mockAdvertisements
    }

    func fetchAdvertisements() async throws -> [AdvertisementModel] {
        if shouldReturnError {
            throw NetworkError.noData
        }
        return mockAdvertisements
    }
}
