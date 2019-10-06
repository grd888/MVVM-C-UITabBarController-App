//
//  StandardButton.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/22/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class StandardButton: UIButton, ButtonAnimatable {
    
    var title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let titleAttributes: [NSAttributedString.Key:Any] = [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .semibold),
            .foregroundColor: UIColor.white,
        ]
        setTitleColor(.white, for: .normal)
        setAttributedTitle(NSAttributedString(string: title, attributes: titleAttributes), for: .normal)
        backgroundColor = .black
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
        addTarget(self, action: #selector(buttonTapped), for: .touchDown)
    }
    
    @objc func buttonTapped() {
        animateScaleOnPress()
    }
}
