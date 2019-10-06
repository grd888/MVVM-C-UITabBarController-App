//
//  HomeViewController.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/22/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: Views
    
    var displayMode = Theme.displayMode
    var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.bounces = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var carouselView: UIView!
    
    let carouselHeight: CGFloat = 250
    let genreDisplayHeight: CGFloat = 120
    
    // MARK: View Setup
    
    var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "Home"
        view.backgroundColor = displayMode == .dark ? .black : .white

        setupScrollView()
        setupContainerView()
        setupSlideShow()
        setupGenreDisplays()
    }
    

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupContainerView() {
        scrollView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setupSlideShow() {
        let slideShowViewModel = viewModel.slideShowViewModel()
        
        let slideVC = SlideShowViewController(viewModel: slideShowViewModel)
        slideVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(slideVC)
        carouselView = slideVC.view
        containerView.addSubview(carouselView)
        let constraints = [
            carouselView.topAnchor.constraint(equalTo: containerView.topAnchor),
            carouselView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            carouselView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            carouselView.heightAnchor.constraint(equalToConstant: carouselHeight)
        ]
        NSLayoutConstraint.activate(constraints)
        
        slideVC.didMove(toParent: self)
        
    }
    var genreViews: [UIViewController] = []
    
    func setupGenreDisplays() {
        let genreViewModels = viewModel.genreViewModels()
        var upperView: UIView = carouselView
        genreViewModels.forEach { (viewModel) in
            let title = viewModel.genre.uppercased()            
            let genreVC = HorizontalCollectionViewController(viewModel:viewModel)
            addChild(genreVC)
            let genreView = makeGenreView(with: genreVC.view, title: title, height: genreDisplayHeight)
            containerView.addSubview(genreView)
            constrain(view: genreView, below: upperView, withHeight: genreDisplayHeight)
            
            genreVC.didMove(toParent: self)
            genreViews.append(genreVC)
            upperView = genreView
        }
        upperView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32).isActive = true
    }
    
    func constrain(view: UIView, below upperview: UIView, withHeight height: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: upperview.bottomAnchor),
            view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            view.rightAnchor.constraint(equalTo: containerView.rightAnchor),
        ])
    }
    
    func makeGenreView(with view: UIView, title: String, height: CGFloat) -> UIView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(GenreHeaderView(title: title))
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        stackView.addArrangedSubview(view)
        return stackView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
