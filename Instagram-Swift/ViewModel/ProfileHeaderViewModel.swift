//
//  ProfileHeaderViewModel.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.09.2022.
//

import Foundation

struct ProfileHeaderViewModel{
    let user: User
    var fullname: String {
        return user.fullname
    }
    var profileImageUrl: URL {
        return URL(string: user.profileImageUrl)!
    }
    
    init(user: User) {
        self.user = user
    }
}
