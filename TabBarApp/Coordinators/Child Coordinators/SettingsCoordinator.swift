//
//  SettingsCoordinator.swift
//  TabBarApp
//
//  Created by Greg Delgado on 10/4/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class SettingsCoordinator: Coordinator {
    // MARK: - Properties
    
    private var navigationController: UINavigationController!

    // MARK: - Public API
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    // MARK: - Setup
    
    init(tabBarItem: UITabBarItem) {
        super.init()
        setupRootViewController(with: makeMenuViewController(with: tabBarItem))
    }
    
    private func setupRootViewController(with viewController: UIViewController) {
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = self
    }
    
    private func makeMenuViewController(with tabBarItem: UITabBarItem) -> UIViewController {
        let vc =  SettingsViewController(viewModel: SettingsViewModel())
        vc.tabBarItem = tabBarItem
        setupListeners(viewController: vc)
        return vc
    }
    
    private func setupListeners(viewController: SettingsViewController) {
        viewController.didSelectProfile = showProfile(_:)
    }
    
    // MARK: - Helper Methods
    
    override func start() {
    }
    
    private func showProfile(_ profile: ProfileViewModel) {
        let vc = ProfileHomeViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
