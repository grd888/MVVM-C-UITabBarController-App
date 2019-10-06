//
//  LightContentNavigationController.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/21/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class LightContentNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
