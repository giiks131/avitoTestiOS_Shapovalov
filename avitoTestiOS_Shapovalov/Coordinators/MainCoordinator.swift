//
//  MainCoordinator.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import UIKit

/// MainCoordinator is responsible for handling the navigation flow of the application.
class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    // MARK: - Properties

    /// Holds any child coordinators to prevent them from being deallocated.
    var childCoordinators = [Coordinator]()

    /// The UINavigationController to push and pop view controllers.
    var navigationController: UINavigationController

    // MARK: - Initialization

    /// Initializes a new MainCoordinator.
    /// - Parameter navigationController: The UINavigationController that will be used to push and pop view controllers.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Coordinator

    /// Starts the coordinator's flow by pushing the initial view controller.
    func start() {
        let productListViewModel = ProductListViewModel(advertisementService: ServiceLocator.shared.advertisementService)
        let vc = ProductListViewController(viewModel: productListViewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    /// Navigates to the product detail screen.
    /// - Parameter id: The ID of the product to be displayed.
    func navigateToProductDetail(with id: String) {
        let productDetailViewModel = ProductDetailViewModel(detailService: ServiceLocator.shared.detailService, advertisementId: id)
        let detailVC = ProductDetailViewController(viewModel: productDetailViewModel)
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }

}

// MARK: - Coordinator Protocol

/// Defines the basic structure and functionalities for a coordinator.
protocol Coordinator {

    /// Holds any child coordinators to prevent them from being deallocated.
    var childCoordinators: [Coordinator] { get set }

    /// The UINavigationController to push and pop view controllers.
    var navigationController: UINavigationController { get set }

    /// Starts the coordinator's flow by pushing the initial view controller.
    func start()
}
