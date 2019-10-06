//
//  AppCoordinator.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/26/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var rootViewController: UIViewController {
        return tabBarController
    }
    
    private let tabBarController = UITabBarController()

    // MARK: - Initialization

    override init() {
        super.init()
        setup()
    }
    
    func setup() {
        setupTabBarController()
        setupCoordinators()
    }
    
    func setupTabBarController() {
        tabBarController.tabBar.tintColor = .white
    }
    
    func setupCoordinators() {
        let homeCoordinator = makeHomeCoordinator()
        let photosCoordinator = makePhotosCoordinator()
        let settingsCoordinator = makeSettingsCoordinator()
        
        tabBarController.viewControllers = [
            homeCoordinator.rootViewController,
            photosCoordinator.rootViewController,
            settingsCoordinator.rootViewController
        ]
        
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(photosCoordinator)
        childCoordinators.append(settingsCoordinator)
    }
    
    func makeHomeCoordinator() -> HomeCoordinator {
        return HomeCoordinator(tabBarItem: UITabBarItem(title: "Home", image: UIImage(named: "ic_home"), selectedImage: UIImage(named: "ic_home_filled")))
    }
    
    func makePhotosCoordinator() -> PhotosCoordinator {
        return PhotosCoordinator(tabBarItem:  UITabBarItem(title: "Photos", image: UIImage(named: "ic_gallery"), selectedImage: UIImage(named: "ic_gallery_filled")))
    }
    
    func makeSettingsCoordinator() -> SettingsCoordinator {
        return SettingsCoordinator(tabBarItem: UITabBarItem(title: "Settings", image: UIImage(named: "ic_settings"), selectedImage: UIImage(named: "ic_settings_filled")))
    }
    
    override func start() {
        childCoordinators.forEach { (childCoordinator) in
            childCoordinator.start()
        }
    }
}
