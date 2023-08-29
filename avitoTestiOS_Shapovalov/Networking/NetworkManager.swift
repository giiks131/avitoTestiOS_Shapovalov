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

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchAdvertisements() async throws -> [AdvertisementModel] {
        let urlString = "https://www.avito.st/s/interns-ios/main-page.json"
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decodedData = try JSONDecoder().decode(AdvertisementRoot.self, from: data)
            return decodedData.advertisements
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func fetchAdvertisementDetail(for id: String) async throws -> AdvertisementDetailModel {
        let urlString = "https://www.avito.st/s/interns-ios/details/\(id).json"
        guard let url = URL(string: urlString) else { throw NetworkError.badURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(AdvertisementDetailModel.self, from: data)
        return decodedData
    }
}
