//
//  AdvertisementServiceTests.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import XCTest
@testable import avitoTestiOS_Shapovalov

final class AdvertisementServiceTests: XCTestCase {

    func testFetchAdvertisements() async throws {
        let testDate = Date()
        let mockService = MockAdvertisementService(mockAdvertisements: [
            AdvertisementModel(id: "1", title: "Ad 1", price: "100", location: "Location 1", imageUrl: "url1", createdDate: testDate),
            AdvertisementModel(id: "2", title: "Ad 2", price: "200", location: "Location 2", imageUrl: "url2", createdDate: testDate)
        ])

        do {
            let advertisements = try await mockService.fetchAdvertisements()
            XCTAssertNotNil(advertisements)
            XCTAssertEqual(advertisements.count, 2)
            XCTAssertEqual(advertisements.first?.id, "1")
        } catch {
            XCTFail("Expected to fetch advertisements, got \(error) instead")
        }
    }
}
