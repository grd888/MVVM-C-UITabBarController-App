
//
//  PhotosViewModel.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/24/19.
//  Copyright © 2019 greg. All rights reserved.
//

import Foundation

class PhotosViewModel {
    
    private let images = ModelFactory.dummyImages()
    var pageTitle: String = "Photos"
    var numberOfImages: Int {
        return images.count
    }
    
    func image(at index: Int) -> ImageModel {
        return images[index]
    }
}
