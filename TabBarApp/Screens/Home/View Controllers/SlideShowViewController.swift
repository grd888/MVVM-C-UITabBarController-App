//
//  SlideShowViewController.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/22/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class SlideShowViewController: UIPageViewController {
    
    weak var pageControllerDelegate: PageControllerDelegate?
    
    private var viewModel: SlideShowViewModel!
    private var orderedViewControllers = [UIViewController]()
    private var pageControl = UIPageControl()
    
    init(viewModel: SlideShowViewModel) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.viewModel = viewModel
        
        dataSource = self
        delegate = self
        pageControllerDelegate = self
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
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
    }
    
    func loadData() {
        orderedViewControllers = viewModel.images.map{ SlideContentViewController(imageModel: $0)}
        pageControllerDelegate?.pageViewController(self, didUpdatePageCount: orderedViewControllers.count)
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension SlideShowViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        
        let count = orderedViewControllers.count
        guard count != nextIndex else {
            return orderedViewControllers.first
        }
        guard count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let firstViewController = viewControllers?.first, let index = orderedViewControllers.firstIndex(of: firstViewController) {
            pageControllerDelegate?.pageViewController(self, didUpdatePageIndex: index)
        }
    }
}

extension SlideShowViewController: PageControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didUpdatePageCount count: Int) {
        
        pageControl.numberOfPages = count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didUpdatePageIndex index: Int) {
        
        pageControl.currentPage = index
    }
}

protocol PageControllerDelegate: class {
    
    func pageViewController(_ pageViewController: UIPageViewController, didUpdatePageCount count: Int)
    
    func pageViewController(_ pageViewController: UIPageViewController, didUpdatePageIndex index: Int)
}
