
//
//  HomeViewModel.swift
//  TabBarApp
//
//  Created by Greg Delgado on 10/5/19.
//  Copyright © 2019 greg. All rights reserved.
//

import Foundation

struct HomeViewModel {
    var carouselImages = ModelFactory.carouselImages()
    var genres = ["cats","city","food","sports","transport"]
    func slideShowViewModel() -> SlideShowViewModel {
        return SlideShowViewModel(images: carouselImages)
    }
    
    func genreViewModels() -> [GenreViewModel] {
        return genres.map { genre in
            let images = (1...10).map{ _ in
                return ImageModel(url: URL(string: "https://loremflickr.com/320/240/\(genre)")!)
            }
            return GenreViewModel(genre: genre, images: images)
        }
    }
}
