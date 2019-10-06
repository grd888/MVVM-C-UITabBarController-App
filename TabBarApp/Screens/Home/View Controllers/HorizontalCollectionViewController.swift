//
//  HorizontalCollectionViewController.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/23/19.
//  Copyright © 2019 greg. All rights reserved.
//

import UIKit

class HorizontalCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var viewModel: GenreViewModel!
    var flowLayout: UICollectionViewFlowLayout!
    var displayMode: DisplayMode = Theme.displayMode
    init(viewModel: GenreViewModel) {
        self.viewModel = viewModel
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        collectionView.backgroundColor = displayMode == .dark ? .black : .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(GenrePhotoCell.self, forCellWithReuseIdentifier: GenrePhotoCell.reuseIdentifier)
        collectionView.register(GenreHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GenreHeaderView")
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfImages ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenrePhotoCell.reuseIdentifier, for: indexPath) as! GenrePhotoCell
        let model = viewModel.image(at: indexPath.row)
        cell.configure(with: model, session: URLSession.shared)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 177, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}
