//
//  GenrePhotoCell.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/23/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class GenrePhotoCell: UICollectionViewCell {
    var dataTask: URLSessionDataTask?
    var displayMode = Theme.displayMode
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = displayMode == .dark ? .black : UIColor(white: 0.95, alpha: 1)
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicatorView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
    }
    
    func configure(with imageModel: ImageModel, session: URLSession) {
        
        let url = imageModel.imageURL
        activityIndicatorView.startAnimating()
        
        let dataTask = session.dataTask(with: url) { [weak self] (data, _, _) in
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
            }
            guard let data = data else {
                return
            }
            
            let image = UIImage(data: data)
           
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                    if self?.imageView.image == nil {
                        self?.imageView.alpha = 0
                    }
                }, completion: {_ in
                    self?.activityIndicatorView.stopAnimating()
                    self?.imageView.image = image
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self?.imageView.alpha = 1.0
                    }, completion: nil)
                })
            }
        }
        
        dataTask.resume()
        
        self.dataTask = dataTask
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dataTask?.cancel()
        imageView.image = nil
    }
}
