//
//  Advertisement.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import Foundation

struct AdvertisementModel: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: String
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageUrl = "image_url"
        case createdDate = "created_date"
    }
}

struct AdvertisementRoot: Codable {
    let advertisements: [AdvertisementModel]
}
