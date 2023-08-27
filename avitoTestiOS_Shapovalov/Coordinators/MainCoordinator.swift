//
//  MainCoordinator.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class MainCoordinator: NSObject {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

//    func start() {
//        let vc = ProductListViewController.instantiate()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: false)
//    }
//
//    func showDetail(_ id: String) {
//        let detailVC = ProductDetailViewController.instantiate()
//        detailVC.productId = id
//        detailVC.coordinator = self
//        navigationController.pushViewController(detailVC, animated: true)
//    }
}
