//
//  ProfileViewModel.swift
//  TabBarApp
//
//  Created by Greg Delgado on 10/4/19.
//  Copyright © 2019 greg. All rights reserved.
//

import Foundation

struct ProfileViewModel: MenuOption {

    var profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var imageURL: URL? {
        return nil
    }
    
    var image: String {
        return "avatar"
    }
    
    var description: String {
        return "\(profile.firstname ?? "") \(profile.lastname ?? "")".trimmingCharacters(in: .whitespaces)
    }
    
}
