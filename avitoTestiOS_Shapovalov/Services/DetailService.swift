//
//  DetailService.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

struct DetailService: DetailFetchable {

    private let networkManager = NetworkManager()

    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel {
        let endpoint = "/details/\(id).json"
        do {
            let detail: AdvertisementDetailModel = try await networkManager.fetchData(from: endpoint)
            return detail
        } catch {
            if let _ = error as? DecodingError {
                throw NetworkError.decodingError
            } else if let urlError = error as? URLError, urlError.code == .badURL {
                throw NetworkError.badURL
            } else {
                throw NetworkError.noData
            }
        }
    }
}
