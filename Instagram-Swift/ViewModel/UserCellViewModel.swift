//
//  UserCellViewModel.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 15.10.2022.
//

import Foundation
struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl: URL?{
        return URL(string: user.profileImageUrl)
    }
    var username: String?{
        return user.username
    }
    var fullname: String?{
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}
