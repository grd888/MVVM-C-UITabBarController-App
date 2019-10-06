//
//  ProfileCoordinator.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/26/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class ProfileCoordinator: Coordinator {
    // MARK: - Properties
    
    private var navigationController: UINavigationController!

    // MARK: - Public API
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(viewController: UIViewController) {
        super.init()
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController.delegate = self
    }
    
    func showProfile() {
        
    }
    
    override func start() {
        
    }
}
