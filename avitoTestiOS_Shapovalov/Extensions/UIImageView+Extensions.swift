//
//  UIImageView+Extensions.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 28/08/23.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
