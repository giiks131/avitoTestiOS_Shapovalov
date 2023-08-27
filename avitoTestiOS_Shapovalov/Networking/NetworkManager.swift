//
//  NetworkManager.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

// Networking/NetworkManager.swift

import Foundation

class NetworkManager {

    let baseURL = "https://www.avito.st/s/interns-ios/"

    enum NetworkError: Error {
        case badURL
        case decodingError
    }

    func fetchMainPage() async throws -> [Advertisement] {
        let urlString = "\(baseURL)main-page.json"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let decodedData = try JSONDecoder().decode([Advertisement].self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }

    func fetchDetails(for id: String) async throws -> AdvertisementDetail {
        let urlString = "\(baseURL)details/\(id).json"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let decodedData = try JSONDecoder().decode(AdvertisementDetail.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
}
