//
//  DetailServiceTests.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import XCTest
@testable import avitoTestiOS_Shapovalov

final class DetailServiceTests: XCTestCase {

    func testFetchAdvertisementDetails() async throws {
        let mockService = MockDetailService(mockDetail: AdvertisementDetailModel(id: "1", title: "Ad 1", price: "100", location: "Location 1", imageUrl: "url1", createdDate: "date1", description: "Description", email: "email@email.com", phoneNumber: "123456789", address: "Address 1"))

        do {
            let advertisementDetail = try await mockService.fetchAdvertisementDetail(for: "1")
            XCTAssertNotNil(advertisementDetail)
            XCTAssertEqual(advertisementDetail.id, "1")
            XCTAssertEqual(advertisementDetail.title, "Ad 1")
        } catch {
            XCTFail("Expected to fetch advertisement details, got \(error) instead")
        }
    }
}
