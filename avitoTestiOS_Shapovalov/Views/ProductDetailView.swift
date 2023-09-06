//
//  ProductDetailView.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

/// A custom UIView to display the detailed information of a product.
class ProductDetailView: UIView {
    
    // MARK: - UI Elements
    
    /// A scroll view to contain all other UI elements, allowing for vertical scrolling.
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    /// The main content view within the scroll view where all other UI elements are added.
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// An image view to display the product image.
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// A label to display the price of the product.
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label to display the title of the product.
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A separator line below the title.
    lazy var titleSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// A label to display the location of the product.
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label to display the address associated with the product.
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label to indicate the description section.
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label to display the description of the product.
    lazy var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label to display the email address associated with the product.
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label to display the phone number associated with the product.
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A label to display the creation date of the product advertisement.
    lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    /// Initializes the ProductDetailView.
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUIElements()
        setupConstraints()
    }
    
    /// Required initializer, not implemented.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI Elements
    
    /// Sets up the UI elements by adding them as subviews.
    private func setupUIElements() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(productImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleSeparator)
        contentView.addSubview(locationLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionText)
        contentView.addSubview(emailLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(createdDateLabel)
    }
    
    // MARK: - Setup Constraints
    
    /// Sets up the constraints for the UI elements.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: createdDateLabel.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/16),
            
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleSeparator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            titleSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            locationLabel.topAnchor.constraint(equalTo: titleSeparator.bottomAnchor, constant: 16),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            addressLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionText.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            descriptionText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 24),
            emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            createdDateLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            createdDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            createdDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            createdDateLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
            
        ])
    }
}
