//
//  SlideShowViewModel.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/22/19.
//  Copyright © 2019 greg. All rights reserved.
//

import Foundation

class SlideShowViewModel {
    var images: [ImageModel]
    
    var numberOfImages: Int {
        return images.count
    }
    
    init(images: [ImageModel]) {
        self.images = images
    }
    
}
