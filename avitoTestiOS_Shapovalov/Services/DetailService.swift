//
//  DetailService.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

/// A service responsible for fetching advertisement details from a network source.
struct DetailService: DetailFetchable {
    
    private let networkManager = NetworkManager()
    
    /// Function to asynchronously fetch advertisement details for a given ID.
    /// - Parameter id: The identifier of the advertisement.
    /// - Throws: An error if any occur during the process.
    /// - Returns: An instance of AdvertisementDetailModel.
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
