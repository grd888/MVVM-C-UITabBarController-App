//
//  GenreHeaderView.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/23/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class GenreHeaderView: UIView {
    var title: String?
    let displayMode = Theme.displayMode
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = displayMode == .dark ? .black : .white
        label.textColor = displayMode == .dark ? .white : .black
        label.text = title
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
