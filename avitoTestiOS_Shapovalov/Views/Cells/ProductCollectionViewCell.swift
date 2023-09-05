//
//  ProductCollectionViewCell.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

// Custom Collection View Cell for displaying Product information
class ProductCollectionViewCell: UICollectionViewCell {
    
    // Identifier for the cell
    static let identifier = "ProductCollectionViewCell"
    
    // UI Elements
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    // Prepare for cell reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        dateLabel.text = nil
    }

    
    // Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup UI
    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(locationLabel)
        addSubview(dateLabel)
    }
    
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
    
    // Configure cell with model
    func configure(with model: AdvertisementModel) {
        if let imageUrl = URL(string: model.imageUrl) {
            imageView.loadImage(from: imageUrl, placeholder: UIImage(named: "placeholder")) {
                self.titleLabel.text = model.title
                self.priceLabel.text = model.price
                self.locationLabel.text = model.location

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM yyyy"
                if let date = model.createdDate {
                    self.dateLabel.text = dateFormatter.string(from: date)
                }
                self.layoutIfNeeded()
            }
        }
    }
}
