//
//  UIImageView+Extensions.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 28/08/23.
//

import UIKit

private var imageLoadingUrl: UInt8 = 0

extension UIImageView {
    var loadingURL: URL? {
        get {
            return objc_getAssociatedObject(self, &imageLoadingUrl) as? URL
        }
        set {
            objc_setAssociatedObject(self, &imageLoadingUrl, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func loadImage(from url: URL, placeholder: UIImage? = nil) async {
        self.image = placeholder
        loadingURL = url
        
        if let cachedImage = CacheManager.shared.getImage(key: url.absoluteString) {
            self.image = cachedImage
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                CacheManager.shared.setImage(key: url.absoluteString, image: image)
                if self.loadingURL == url {
                    self.image = image
                }
            }
        } catch {
            // Handle error
        }
    }
}
