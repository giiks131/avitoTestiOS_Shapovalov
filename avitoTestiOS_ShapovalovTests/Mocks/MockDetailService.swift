//
//  MockDetailService.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation
@testable import avitoTestiOS_Shapovalov

class MockDetailService: DetailFetchable {
    var shouldReturnError: Bool
    var mockDetail: AdvertisementDetailModel?

    init(shouldReturnError: Bool = false, mockDetail: AdvertisementDetailModel? = nil) {
        self.shouldReturnError = shouldReturnError
        self.mockDetail = mockDetail
    }

    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel {
        if shouldReturnError {
            throw NetworkError.noData
        }
        if let detail = mockDetail {
            return detail
        }
        throw NetworkError.noData  // or some other error
    }
}
