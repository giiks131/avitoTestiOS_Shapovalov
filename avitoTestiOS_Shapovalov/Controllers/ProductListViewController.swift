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
                DispatchQueue.main.async {
                    self.productListView.collectionView.reloadData()
                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisements.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        let advertisement = advertisements[indexPath.row]
        cell.configure(with: advertisement)
        // Load image for the cell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let coordinator = coordinator {
            let selectedAdvertisement = advertisements[indexPath.row]
            coordinator.navigateToProductDetail(with: selectedAdvertisement.id)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 8) / 2
        return CGSize(width: width, height: width * 2)

    }
}
