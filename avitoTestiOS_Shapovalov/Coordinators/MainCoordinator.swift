//
//  MainCoordinator.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ProductListViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func navigateToProductDetail(with id: String) {
        let detailVC = ProductDetailViewController()
        detailVC.advertisementId = id
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
}


protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
