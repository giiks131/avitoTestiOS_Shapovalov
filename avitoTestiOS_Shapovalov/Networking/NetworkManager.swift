//
//  NetworkManager.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import Foundation

/// Protocols defining the networking capabilities
protocol AdvertisementFetchable {
    func fetchAdvertisements() async throws -> [AdvertisementModel]
}

protocol DetailFetchable {
    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel
}


/// A struct responsible for networking operations.
struct NetworkManager {
    
    /// The base URL for API requests.
    static let baseURL = "https://www.avito.st/s/interns-ios"
    
    /// A generic asynchronous function to fetch data from a given endpoint.
    /// - Parameter endpoint: The specific API endpoint for the data request.
    /// - Returns: A generic value conforming to Decodable protocol.
    /// - Throws: An error if any occur during the process.
    func fetchData<T: Decodable>(from endpoint: String) async throws -> T {
        
        /// Construct the full URL from the given endpoint.
        guard let url = URL(string: NetworkManager.baseURL + endpoint) else {
            throw NetworkError.badURL
        }
        
        /// Asynchronously fetch data from the URL.
        let (data, _) = try await URLSession.shared.data(from: url)
        
        /// Initialize JSONDecoder instance.
        let decoder = JSONDecoder()
        
        /// Set the date decoding strategy using a custom date format.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        /// Attempt to decode the received data.
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
}
