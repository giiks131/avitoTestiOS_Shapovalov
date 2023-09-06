//
//  ServiceLocator.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 31/08/23.
//

import Foundation

/// Singleton class responsible for providing service instances.
class ServiceLocator {
    
    static let shared = ServiceLocator()
    
    /// Provides an instance of AdvertisementService.
    var advertisementService: AdvertisementService {
        return AdvertisementService()
    }
    
    /// Provides an instance of DetailService.
    var detailService: DetailService {
        return DetailService()
    }
}
