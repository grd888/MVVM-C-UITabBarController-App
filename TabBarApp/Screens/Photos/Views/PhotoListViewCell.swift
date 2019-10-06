//
//  PhotoListViewCell.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/24/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class PhotoListViewCell: UITableViewCell {
    
    var dataTask: URLSessionDataTask?
    var displayMode = Theme.displayMode
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.primaryFontColor
        label.font = Theme.primaryFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cameraModelLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.secondaryFontColor
        label.font = Theme.secondaryFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lensModelLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.secondaryFontColor
        label.font = Theme.secondaryFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likeImageView: UIImageView = {
        let imageView = UIImageView(image: likedImage)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var likeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.secondaryFontColor
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var stackContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let unlikedImage = UIImage(named: "ic_unlike")
    let likedImage = UIImage(named: "ic_like")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = .white
        contentView.addSubview(photoImageView)
        contentView.addSubview(activityIndicatorView)
        contentView.addSubview(stackContainerView)
        stackContainerView.addSubview(leftStackView)
        stackContainerView.addSubview(rightStackView)
        leftStackView.addArrangedSubview(nameLabel)
        leftStackView.addArrangedSubview(cameraModelLabel)
        leftStackView.addArrangedSubview(lensModelLabel)
        rightStackView.addArrangedSubview(likeImageView)
        rightStackView.addArrangedSubview(likeLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let viewWidth = contentView.bounds.width
        let photoHeight = viewWidth * 0.75
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: photoHeight),
            
            activityIndicatorView.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            
            stackContainerView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            stackContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            leftStackView.leftAnchor.constraint(equalTo: stackContainerView.leftAnchor, constant: 8.0),
            leftStackView.topAnchor.constraint(equalTo: stackContainerView.topAnchor, constant: 8.0),
            leftStackView.bottomAnchor.constraint(equalTo: stackContainerView.bottomAnchor, constant: -8.0),
            
            rightStackView.leftAnchor.constraint(equalTo: leftStackView.rightAnchor, constant: 8.0),
            rightStackView.rightAnchor.constraint(equalTo: stackContainerView.rightAnchor, constant: -20.0),
            rightStackView.centerYAnchor.constraint(equalTo: stackContainerView.centerYAnchor),
            rightStackView.widthAnchor.constraint(equalToConstant: 60.0),
            likeImageView.heightAnchor.constraint(equalToConstant: 24.0)
            
        ])
        
    }
    
    func configure(with imageModel: ImageModel, session: URLSession) {
        nameLabel.text = imageModel.owner
        cameraModelLabel.text = imageModel.cameraModel
        lensModelLabel.text = imageModel.lensModel
        likeLabel.text = "\(imageModel.likes)"
        configureImage(with: imageModel, session: session)
    }
    
    func configureImage(with imageModel: ImageModel, session: URLSession) {
        let url = imageModel.imageURL
        activityIndicatorView.startAnimating()
        
        let dataTask = session.dataTask(with: url) { [weak self] (data, _, _) in
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating()
            }
            guard let data = data else {
                return
            }
            
            let image = UIImage(data: data)?.resizedImage(with: CGSize(width: 177, height: 100))
            
            DispatchQueue.main.async {
                self?.photoImageView.alpha = 0
                self?.photoImageView.image = image
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                    self?.photoImageView.alpha = 1.0
                }, completion: nil)
            }
            
        }
        
        dataTask.resume()
        
        self.dataTask = dataTask
    }
}
