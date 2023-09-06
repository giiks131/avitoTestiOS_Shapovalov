//
//  UIImageView+Extensions.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 28/08/23.
//

import UIKit

/// Associated object key for storing the loading URL.
private var imageLoadingUrl: UInt8 = 0

extension UIImageView {

    /// Property to get or set the URL being loaded by the UIImageView.
    var loadingURL: URL? {
        get {
            return objc_getAssociatedObject(self, &imageLoadingUrl) as? URL
        }
        set {
            objc_setAssociatedObject(self, &imageLoadingUrl, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// Asynchronously loads an image from a URL and sets it to the UIImageView.
    /// - Parameters:
    ///   - url: The URL from which to load the image.
    ///   - placeholder: An optional placeholder image to display while the image is loading.
    func loadImage(from url: URL, placeholder: UIImage? = nil) async {

        // Set the placeholder image initially
        self.image = placeholder

        // Set the loading URL
        loadingURL = url

        // Check if the image is already cached
        if let cachedImage = CacheManager.shared.getImage(key: url.absoluteString) {
            self.image = cachedImage
            return
        }

        // Fetch the image data asynchronously
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {

                // Cache the image
                CacheManager.shared.setImage(key: url.absoluteString, image: image)

                // Check if the image view is still supposed to load this URL
                if self.loadingURL == url {

                    // Set the image
                    self.image = image
                }
            }
        } catch let error {
            print("Image Loading Error: \(error.localizedDescription)")
        }
    }
}
