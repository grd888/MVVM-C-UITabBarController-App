//
//  AppDelegate.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/20/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    private let appCoordinator = AppCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.barTintColor = .black
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()
        
        appCoordinator.start()
        return true
    }
}

