//
//  AdvertisementServiceTests.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import XCTest
@testable import avitoTestiOS_Shapovalov

/// Unit tests for AdvertisementService.
final class AdvertisementServiceTests: XCTestCase {

    /// Tests the fetchAdvertisements function using a mock service.
    func testFetchAdvertisements() async throws {
        // Arrange
        let testDate = Date()
        let mockService = MockAdvertisementService(mockAdvertisements: [
            AdvertisementModel(id: "1", title: "Ad 1", price: "100", location: "Location 1", imageUrl: "url1", createdDate: testDate),
            AdvertisementModel(id: "2", title: "Ad 2", price: "200", location: "Location 2", imageUrl: "url2", createdDate: testDate)
        ])

        // Act & Assert
        do {
            let advertisements = try await mockService.fetchAdvertisements()
            XCTAssertNotNil(advertisements, "Advertisements should not be nil.")
            XCTAssertEqual(advertisements.count, 2, "Advertisements count should be 2.")
            XCTAssertEqual(advertisements.first?.id, "1", "First advertisement ID should be '1'.")
        } catch {
            XCTFail("Expected to fetch advertisements, got \(error) instead.")
        }
    }
}
