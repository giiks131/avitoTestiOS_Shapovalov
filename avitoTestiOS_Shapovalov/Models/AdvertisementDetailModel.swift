//
//  AdvertisementDetail.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import Foundation

// Model representing the details of an advertisement
struct AdvertisementDetailModel: Codable {
    let id: String          // Unique identifier for the advertisement
    let title: String       // Title of the advertisement
    let price: String       // Price of the item being advertised
    let location: String    // Location where the item is being sold
    let imageUrl: String    // URL of the image of the item
    let createdDate: Date? // Date when the advertisement was created
    let description: String // Detailed description of the item
    let email: String       // Email address for contacting the seller
    let phoneNumber: String // Phone number for contacting the seller
    let address: String     // Physical address where the item can be found

    enum CodingKeys: String, CodingKey {
        case id, title, price, location, description, email, address
        case imageUrl = "image_url"
        case createdDate = "created_date"
        case phoneNumber = "phone_number"
    }
}

// UI model representing the details of an advertisement for the detail view
struct AdvertisementDetailUIModel {
    let id: String
    let title: String
    let price: String
    let location: String
    let imageUrl: URL
    let createdDate: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String

    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy"
        return df
    }()

    init(from model: AdvertisementDetailModel) {
        self.id = model.id
        self.title = model.title
        self.price = model.price
        self.location = model.location
        self.imageUrl = URL(string: model.imageUrl) ?? URL(string: "https://example.com/placeholder")!
        self.description = model.description
        self.email = model.email
        self.phoneNumber = model.phoneNumber
        self.address = model.address
        self.createdDate = model.createdDate.map { Self.dateFormatter.string(from: $0) } ?? ""
    }
}
