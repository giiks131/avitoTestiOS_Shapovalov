//
//  AdvertisementDetail.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import Foundation

struct AdvertisementDetailModel: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image_url: String
    let created_date: String
    let description: String
    let email: String
    let phone_number: String
    let address: String
}
