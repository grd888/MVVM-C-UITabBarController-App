//
//  PromosCoordinator.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/26/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class PhotosCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private var navigationController: UINavigationController!

    // MARK: - Public API
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Setup
    
    init(tabBarItem: UITabBarItem) {
        super.init()
        setupRootViewController(with: makeViewController(with: tabBarItem))
    }
    
    private func setupRootViewController(with viewController: UIViewController) {
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = self
    }
    
    private func makeViewController(with tabBarItem: UITabBarItem) -> UIViewController {
        let vc =  PhotoListViewController(viewModel: PhotosViewModel())
        vc.tabBarItem = tabBarItem
        return vc
    }
    
    // MARK: - Helper Methods
    
    override func start() {}
}
