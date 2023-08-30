//
//  avitoTestiOS_ShapovalovTests.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 29/08/23.
//

import XCTest
@testable import avitoTestiOS_Shapovalov

// Test class for avitoTestiOS_Shapovalov
final class avitoTestiOS_ShapovalovTests: XCTestCase {

    // Test the fetchAdvertisements() method of the NetworkFetchable protocol
    func testFetchAdvertisements() async throws {
        let mockNetworkManager = MockNetworkManager()
        do {
            let advertisements = try await mockNetworkManager.fetchAdvertisements()
            XCTAssertNotNil(advertisements)  // Check that the fetched data is not nil
            XCTAssertEqual(advertisements.count, 2)  // Check that the number of fetched advertisements is correct
            XCTAssertEqual(advertisements.first?.id, "1")  // Check that the first fetched advertisement has the expected id
        } catch {
            XCTFail("Expected to fetch advertisements, got \(error) instead")  // Fail the test if an error is thrown
        }
    }

    // Test the fetchAdvertisementDetail(for:) method of the NetworkFetchable protocol
    func testFetchAdvertisementDetails() async throws {
        let mockNetworkManager = MockNetworkManager()
        do {
            let advertisementDetail = try await mockNetworkManager.fetchAdvertisementDetail(for: "1")
            XCTAssertNotNil(advertisementDetail)  // Check that the fetched data is not nil
            XCTAssertEqual(advertisementDetail.id, "1")  // Check that the fetched advertisement detail has the expected id
            XCTAssertEqual(advertisementDetail.title, "Ad 1")  // Check that the fetched advertisement detail has the expected title
            XCTAssertEqual(advertisementDetail.price, "100")  // Check that the fetched advertisement detail has the expected price
        } catch {
            XCTFail("Expected to fetch advertisement details, got \(error) instead")  // Fail the test if an error is thrown
        }
    }
}
