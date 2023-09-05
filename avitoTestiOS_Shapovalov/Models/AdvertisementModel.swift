//
//  Advertisement.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import Foundation

// Model representing a summary of an advertisement
struct AdvertisementModel: Codable {
    let id: String          // Unique identifier for the advertisement
    let title: String       // Title of the advertisement
    let price: String       // Price of the item being advertised
    let location: String    // Location where the item is being sold
    let imageUrl: String    // URL of the image of the item
    let createdDate: Date? // Date when the advertisement was created

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageUrl = "image_url"
        case createdDate = "created_date"
    }
}

// Root model that wraps an array of AdvertisementModel objects
struct AdvertisementRoot: Codable {
    let advertisements: [AdvertisementModel] // Array of advertisements
}

// UI model representing a summary of an advertisement for the list view
struct AdvertisementUIModel {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: URL
    let createdDate: String

    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy"
        return df
    }()

    init(from model: AdvertisementModel) {
        self.id = model.id
        self.title = model.title
        self.price = model.price
        self.location = model.location
        self.imageUrl = URL(string: model.imageUrl) ?? URL(string: "https://example.com/placeholder")!
        self.createdDate = model.createdDate.map { Self.dateFormatter.string(from: $0) } ?? ""
    }
}
