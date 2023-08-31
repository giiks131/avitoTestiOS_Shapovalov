//
//  AdvertisementService.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

struct AdvertisementService {

    private let networkManager = NetworkManager()

    func fetchAdvertisements() async throws -> [AdvertisementModel] {
        let endpoint = "/main-page.json"
        let root: AdvertisementRoot = try await networkManager.fetchData(from: endpoint)
        return root.advertisements
    }
}
