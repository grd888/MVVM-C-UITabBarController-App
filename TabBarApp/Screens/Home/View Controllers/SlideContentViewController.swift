//
//  SlideContentViewController.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/23/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class SlideContentViewController: UIViewController {

    var imageModel: ImageModel?
    var session = URLSession.shared
    var dataTask: URLSessionDataTask?
    var displayMode = Theme.displayMode
    
    var imageName: String? {
        didSet {
            if let imageName = imageName {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(imageModel: ImageModel) {
        super.init(nibName: nil, bundle: nil)
        self.imageModel = imageModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }
    
    func setupView() {
        view.backgroundColor = displayMode == .dark ? .black : UIColor(white: 0.95, alpha: 1)
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func loadData() {
        //imageName = imageModel?.imageName
        
        if let url = imageModel?.imageURL {
            // Start Activity Indicator View
//            activityIndicatorView.startAnimating()
            
            // Create Data Task

            let dataTask = session.dataTask(with: url) { [weak self] (data, _, _) in
                guard let data = data else {
                    return
                }
                
                // Initialize Image
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {                    
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self?.imageView.alpha = 0
                    }, completion: {_ in
                        self?.imageView.image = image
                        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                            self?.imageView.alpha = 1.0
                        }, completion: nil)
                    })
                }
            }
            
            // Resume Data Task
            dataTask.resume()
            
            self.dataTask = dataTask
        }
    }

}
