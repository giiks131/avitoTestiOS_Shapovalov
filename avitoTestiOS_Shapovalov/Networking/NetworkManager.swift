//
//  NetworkManager.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import Foundation

// Protocol defining the networking capabilities
protocol NetworkFetchable {
    func fetchAdvertisements() async throws -> [AdvertisementModel]
    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel
}

// Singleton class to handle network operations
class NetworkManager: NetworkFetchable {

    // Shared instance for singleton
    static let shared = NetworkManager()

    // Private initializer to restrict object creation
    private init() {}

    // Generic function to fetch data from the network
    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        // Check if the URL is valid
        guard let url = URL(string: urlString) else {
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

    // Fetch a list of advertisements
    func fetchAdvertisements() async throws -> [AdvertisementModel] {
        let urlString = "https://www.avito.st/s/interns-ios/main-page.json"
        let root: AdvertisementRoot = try await fetchData(from: urlString)
        return root.advertisements
    }

    // Fetch details for a single advertisement
    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel {
        let urlString = "https://www.avito.st/s/interns-ios/details/\(id).json"
        let detail: AdvertisementDetailModel = try await fetchData(from: urlString)
        return detail
    }
}
