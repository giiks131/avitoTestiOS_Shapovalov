//
//  AdvertisementService.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

struct AdvertisementService: AdvertisementFetchable {
    
    private let networkManager = NetworkManager()
    
    func fetchAdvertisements() async throws -> [AdvertisementModel] {
        let endpoint = "/main-page.json"
        do {
            let root: AdvertisementRoot = try await networkManager.fetchData(from: endpoint)
            return root.advertisements
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
