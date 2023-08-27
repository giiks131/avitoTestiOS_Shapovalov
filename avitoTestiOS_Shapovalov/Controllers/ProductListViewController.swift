//
//  ProductListViewController.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class ProductListViewController: UIViewController {

    var coordinator: MainCoordinator?
    private var advertisements: [AdvertisementModel] = []
    private let productListView = ProductListView()

    override func loadView() {
        view = productListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        setupCollectionView()
        fetchData()
    }

    private func setupCollectionView() {
        productListView.collectionView.delegate = self
        productListView.collectionView.dataSource = self
        productListView.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }

    private func fetchData() {
        Task {
            do {
                self.advertisements = try await NetworkManager.shared.fetchAdvertisements()
                print(advertisements)
                DispatchQueue.main.async {
                    self.productListView.collectionView.reloadData()
                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisements.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        cell.configure(with: advertisements[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let coordinator = coordinator {
            let selectedAdvertisement = advertisements[indexPath.row]
            coordinator.navigateToProductDetail(with: selectedAdvertisement.id)
        }
    }
}
