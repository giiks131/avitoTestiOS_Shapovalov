//
//  ProductCollectionViewCell.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    static let identifier = "ProductCollectionViewCell"

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true  // Clip it to bounds
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Semibold", size: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // Reset the content of your cell
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        dateLabel.text = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(locationLabel)
        addSubview(dateLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
               imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
               imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
               imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),

            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),

            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }

    func configure(with model: AdvertisementModel) {
            titleLabel.text = model.title
            priceLabel.text = model.price
            locationLabel.text = model.location
            if let imageUrl = URL(string: model.imageUrl) {
                imageView.loadImage(from: imageUrl, placeholder: UIImage(named: "placeholder"))
            }
            dateLabel.text = model.createdDate
        }
}
