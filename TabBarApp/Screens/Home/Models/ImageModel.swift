//
//  ImageModel.swift
//  TabBarApp
//
//  Created by Greg Delgado on 9/22/19.
//  Copyright © 2019 greg. All rights reserved.
//

import Foundation

struct ImageModel {
    var imageName: String
    var imageURL: URL
    var owner: String
    var cameraModel: String
    var lensModel: String
    var likes: Int
    var isLiked: Bool
}

extension ImageModel {
    init(url: URL) {
        self.imageName = ""
        self.imageURL = url
        
        owner = ""
        cameraModel = ""
        lensModel = ""
        likes = 0
        isLiked = false
    }
}
