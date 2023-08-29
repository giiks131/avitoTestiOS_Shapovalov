//
//  MockNetworkManager.swift
//  avitoTestiOS_ShapovalovTests
//
//  Created by Aleksandr Shapovalov on 29/08/23.
//

import Foundation

@testable import avitoTestiOS_Shapovalov

class MockNetworkManager: NetworkFetchable {
    func fetchAdvertisements() async throws -> [AdvertisementModel] {
        return [
            AdvertisementModel(id: "1", title: "Ad 1", price: "100", location: "Location 1", imageUrl: "url1", createdDate: "date1"),
            AdvertisementModel(id: "2", title: "Ad 2", price: "200", location: "Location 2", imageUrl: "url2", createdDate: "date2")
        ]
    }

    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel {
        return AdvertisementDetailModel(id: "1", title: "Ad 1", price: "100", location: "Location 1", image_url: "url1", created_date: "date1", description: "Description", email: "email@email.com", phone_number: "123456789", address: "Address 1")
    }
}
