//
//  NetworkManager.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

// Networking/NetworkManager.swift

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class NetworkManager: NetworkFetchable {

    static let shared = NetworkManager()

    private init() {}

    // Generic function to fetch data
    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }

    // Specific functions that use the generic one
    func fetchAdvertisements() async throws -> [AdvertisementModel] {
        let urlString = "https://www.avito.st/s/interns-ios/main-page.json"
        let root: AdvertisementRoot = try await fetchData(from: urlString)
        return root.advertisements
    }

    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel {
        let urlString = "https://www.avito.st/s/interns-ios/details/\(id).json"
        let detail: AdvertisementDetailModel = try await fetchData(from: urlString)
        return detail
    }
}


protocol NetworkFetchable {
    func fetchAdvertisements() async throws -> [AdvertisementModel]
    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel
}
