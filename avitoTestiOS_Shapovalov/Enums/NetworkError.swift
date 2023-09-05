//
//  NetworkError.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 30/08/23.
//

import Foundation

/// Custom errors to handle various network-related failures
enum NetworkError: Error, LocalizedError {
    case badURL
    case noData
    case decodingError
    
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
