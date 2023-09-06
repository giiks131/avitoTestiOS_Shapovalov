//
//  DetailServiceTests.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import XCTest
@testable import avitoTestiOS_Shapovalov

/// Unit tests for DetailService.
final class DetailServiceTests: XCTestCase {

    /// Tests the fetchAdvertisementDetails function using a mock service.
    func testFetchAdvertisementDetails() async throws {
        // Arrange
        let testDate = Date()
        let mockService = MockDetailService(mockDetail: AdvertisementDetailModel(id: "1", title: "Ad 1", price: "100", location: "Location 1", imageUrl: "url1", createdDate: testDate, description: "Description", email: "email@email.com", phoneNumber: "123456789", address: "Address 1"))

        // Act & Assert
        do {
            let advertisementDetail = try await mockService.fetchAdvertisementDetail(for: "1")
            XCTAssertNotNil(advertisementDetail, "Advertisement detail should not be nil.")
            XCTAssertEqual(advertisementDetail.id, "1", "Advertisement detail ID should be '1'.")
            XCTAssertEqual(advertisementDetail.title, "Ad 1", "Advertisement detail title should be 'Ad 1'.")
        } catch {
            XCTFail("Expected to fetch advertisement details, got \(error) instead.")
        }
    }
}
