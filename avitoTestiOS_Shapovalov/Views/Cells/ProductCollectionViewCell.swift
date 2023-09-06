//
//  ProductCollectionViewCell.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

/// Custom Collection View Cell for displaying Product information
class ProductCollectionViewCell: UICollectionViewCell {
    
    /// Identifier for the cell.
    static let identifier = "ProductCollectionViewCell"
    
    // MARK: - UI Elements
    
    /// UIImageView for displaying the product image.
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// UILabel for displaying the product title.
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// UILabel for displaying the product price.
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// UILabel for displaying the product location.
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// UILabel for displaying the product creation date.
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    
    /// Initializes the cell and sets up its UI.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    /// Prepares the cell for reuse.
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        dateLabel.text = nil
    }
    
    
    /// Required initializer, not implemented.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    /// Sets up the UI elements in the cell.
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(locationLabel)
        addSubview(dateLabel)
    }
    
    /// Sets up the constraints for the UI elements.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            locationLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 18),
            
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 18),
        ])
    }
    
    // MARK: - Configuration
    
    /// Configures the cell with the given AdvertisementUIModel.
    /// - Parameter model: The model to configure the cell.
    func configure(with model: AdvertisementUIModel) async {
        await imageView.loadImage(from: model.imageUrl, placeholder: UIImage(named: "placeholder"))
        self.titleLabel.text = model.title
        self.priceLabel.text = model.price
        self.locationLabel.text = model.location
        self.dateLabel.text = model.createdDate
        self.layoutIfNeeded()
    }
}
