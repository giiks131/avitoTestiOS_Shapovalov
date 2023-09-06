//
//  MockAdvertisementService.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation
@testable import avitoTestiOS_Shapovalov

/// Mock service for testing advertisement fetching.
class MockAdvertisementService: AdvertisementFetchable {
    
    /// Determines whether the mock service should return an error.
    var shouldReturnError: Bool
    
    /// Mock data for advertisements.
    var mockAdvertisements: [AdvertisementModel]
    
    /// Initializes the mock service with optional error flag and mock data.
    /// - Parameters:
    ///   - shouldReturnError: Flag to indicate whether to return an error.
    ///   - mockAdvertisements: Array of mock advertisements.
    init(shouldReturnError: Bool = false, mockAdvertisements: [AdvertisementModel] = []) {
        self.shouldReturnError = shouldReturnError
        self.mockAdvertisements = mockAdvertisements
    }
    
    /// Simulates the fetchAdvertisements API call.
    /// - Returns: An array of AdvertisementModel instances.
    /// - Throws: NetworkError if `shouldReturnError` is true.
    func fetchAdvertisements() async throws -> [AdvertisementModel] {
        if shouldReturnError {
            throw NetworkError.noData
        }
        return mockAdvertisements
    }
}
