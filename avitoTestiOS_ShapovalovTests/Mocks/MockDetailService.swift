//
//  MockDetailService.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation
@testable import avitoTestiOS_Shapovalov

/// Mock service for testing advertisement detail fetching.
class MockDetailService: DetailFetchable {
    
    /// Determines whether the mock service should return an error.
    var shouldReturnError: Bool
    
    /// Mock data for advertisement detail.
    var mockDetail: AdvertisementDetailModel?
    
    /// Initializes the mock service with optional error flag and mock data.
    /// - Parameters:
    ///   - shouldReturnError: Flag to indicate whether to return an error.
    ///   - mockDetail: Mock data for advertisement detail.
    init(shouldReturnError: Bool = false, mockDetail: AdvertisementDetailModel? = nil) {
        self.shouldReturnError = shouldReturnError
        self.mockDetail = mockDetail
    }
    
    /// Simulates the fetchAdvertisementDetail API call.
    /// - Parameters:
    ///   - id: The ID of the advertisement.
    /// - Returns: An instance of AdvertisementDetailModel.
    /// - Throws: NetworkError if `shouldReturnError` is true or mockDetail is nil.
    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel {
        if shouldReturnError {
            throw NetworkError.noData
        }
        if let detail = mockDetail {
            return detail
        }
        throw NetworkError.noData  // or some other error - may be changed
    }
}
