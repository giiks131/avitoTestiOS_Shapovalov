//
//  ProductDetailView.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class ProductDetailView: UIView {
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .red
        label.textAlignment = .center
        label.text = "An error occurred"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(productImageView)
        addSubview(priceLabel)
        addSubview(titleLabel)
        addSubview(locationLabel)
        addSubview(descriptionLabel)
        addSubview(emailLabel)
        addSubview(phoneNumberLabel)
        addSubview(addressLabel)
        addSubview(activityIndicator)
        addSubview(errorLabel)
        addSubview(retryButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 300),
            
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            addressLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 16),
            addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16)
        ])
    }
    
}
