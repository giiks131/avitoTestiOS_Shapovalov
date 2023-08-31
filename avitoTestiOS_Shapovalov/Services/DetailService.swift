//
//  DetailService.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

struct DetailService {

    private let networkManager = NetworkManager()

    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel {
        let endpoint = "/details/\(id).json"
        return try await networkManager.fetchData(from: endpoint)
    }
}
