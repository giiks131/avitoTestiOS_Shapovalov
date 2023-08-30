//
//  NetworkError.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 30/08/23.
//

import Foundation

// Custom errors to handle various network-related failures
enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}
