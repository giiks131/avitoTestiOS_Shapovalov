//
//  NetworkManager.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import Foundation

// MARK: - Networking Protocols

/// Protocol to define methods for fetching advertisements.
protocol AdvertisementFetchable {
    func fetchAdvertisements() async throws -> [AdvertisementModel]
}

/// Protocol to define methods for fetching advertisement details.
protocol DetailFetchable {
    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel
}

// MARK: - NetworkManager

/// Struct responsible for networking operations.
struct NetworkManager {
    
    /// The base URL for API requests.
    static let baseURL = "https://www.avito.st/s/interns-ios"
    
    /// A generic asynchronous function to fetch data from a given endpoint.
    /// - Parameter endpoint: The specific API endpoint for the data request.
    /// - Returns: A generic value conforming to Decodable protocol.
    /// - Throws: An error if any occur during the process.
    func fetchData<T: Decodable>(from endpoint: String) async throws -> T {
        guard let url = URL(string: NetworkManager.baseURL + endpoint) else {
            throw NetworkError.badURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
}
