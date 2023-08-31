//
//  ServiceLocator.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

class ServiceLocator {
    
    static let shared = ServiceLocator()
    
    var advertisementService: AdvertisementService {
        return AdvertisementService()
    }
    
    var detailService: DetailService {
        return DetailService()
    }
}
