//
//  avitoTestiOS_ShapovalovTests.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 29/08/23.
//

import XCTest
@testable import avitoTestiOS_Shapovalov

final class avitoTestiOS_ShapovalovTests: XCTestCase {

    func testFetchAdvertisements() async throws {
        let mockNetworkManager = MockNetworkManager()
        do {
            let advertisements = try await mockNetworkManager.fetchAdvertisements()
            XCTAssertNotNil(advertisements)
            XCTAssertEqual(advertisements.count, 2)
            XCTAssertEqual(advertisements.first?.id, "1")
        } catch {
            XCTFail("Expected to fetch advertisements, got \(error) instead")
        }
    }

    func testFetchAdvertisementDetails() async throws {
        let mockNetworkManager = MockNetworkManager()
        do {
            let advertisementDetail = try await mockNetworkManager.fetchAdvertisementDetail(for: "1")
            XCTAssertNotNil(advertisementDetail)
            XCTAssertEqual(advertisementDetail.id, "1")
            XCTAssertEqual(advertisementDetail.title, "Ad 1")
            XCTAssertEqual(advertisementDetail.price, "100")
        } catch {
            XCTFail("Expected to fetch advertisement details, got \(error) instead")
        }
    }

}
