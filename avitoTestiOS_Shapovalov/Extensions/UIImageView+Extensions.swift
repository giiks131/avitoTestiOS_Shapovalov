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

    func loadImage(from url: URL, placeholder: UIImage? = nil, completion: @escaping () -> Void) {
        self.image = placeholder
        loadingURL = url

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if self?.loadingURL == url {
                        self?.image = image
                        completion()
                    }
                }
            }
        }
    }
}
