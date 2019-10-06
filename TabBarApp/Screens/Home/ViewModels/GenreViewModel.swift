//
//  GenreViewModel.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/23/19.
//  Copyright © 2019 greg. All rights reserved.
//

import Foundation

class GenreViewModel {
    var images = [ImageModel]()
    var genre: String
    
    var numberOfImages: Int {
        return images.count
    }
    
    init(genre: String, images: [ImageModel]) {
        self.images = images
        self.genre = genre
    }
    
    func image(at index: Int) -> ImageModel {
        return images[index]
    }
}
