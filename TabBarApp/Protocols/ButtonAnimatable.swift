//
//  ButtonAnimatable.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/21/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

protocol ButtonAnimatable where Self: UIButton {
    func animateScaleOnPress()
}

extension ButtonAnimatable {
    func animateScaleOnPress() {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform.identity
            }) { (_) in
                
            }
        }
    }
}
