//
//  NetworkManager.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import Foundation

// Protocols defining the networking capabilities
protocol AdvertisementFetchable {
    func fetchAdvertisements() async throws -> [AdvertisementModel]
}

protocol DetailFetchable {
    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel
}


struct NetworkManager {
    
    // The base URL for API requests
    static let baseURL = "https://www.avito.st/s/interns-ios"
    
    // Generic function to fetch data from the network
    func fetchData<T: Decodable>(from endpoint: String) async throws -> T {
        // Construct the full URL
        guard let url = URL(string: NetworkManager.baseURL + endpoint) else {
            throw NetworkError.badURL
        }
        
        // Perform the data fetching
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Decode the received data
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
}
