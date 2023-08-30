//
//  ProductListView.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

// Custom UIView containing a UICollectionView for displaying Product List
class ProductListView: UIView {
    
    // UI Elements
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        setupConstraints()
    }
    
    // Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
