//
//  ProductDetailView.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class ProductDetailView: UIView {

    // Image View for the product
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // Label for the title
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Label for the price
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Label for the location
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Label for the description
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Label for the email
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Label for the phone number
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // Label for the address
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        // Add subviews
        addSubview(productImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(locationLabel)
        addSubview(descriptionLabel)
        addSubview(emailLabel)
        addSubview(phoneNumberLabel)
        addSubview(addressLabel)

        // Setup Constraints
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints for ImageView
            productImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),

            // Constraints for Title Label
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            // Constraints for Price Label
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            // Constraints for Location Label
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            // Constraints for Description Label
            descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),

            // Constraints for Email Label
            emailLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            // Constraints for Phone Number Label
            phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            // Constraints for Address Label
            addressLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
}
