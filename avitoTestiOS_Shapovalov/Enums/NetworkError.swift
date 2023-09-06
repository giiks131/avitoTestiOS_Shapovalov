//
//  NetworkError.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 30/08/23.
//

import Foundation

/// Custom enum to represent network-related errors.
/// - badURL: Indicates that the URL is incorrect or malformed
/// - noData: Indicates that no data was received from the server
/// - decodingError: Indicates that an error occurred while decoding the received data
enum NetworkError: Error, LocalizedError {
    case badURL
    case noData
    case decodingError

    /// Provides a localized description of the error.
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Неверный URL."
        case .noData:
            return "Данные от сервера не получены."
        case .decodingError:
            return "Ошибка при декодировании данных."
        }
    }
}
