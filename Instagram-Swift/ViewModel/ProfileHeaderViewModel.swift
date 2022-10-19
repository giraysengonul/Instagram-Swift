//
//  ProfileHeaderViewModel.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.09.2022.
//

import Foundation
import UIKit

struct ProfileHeaderViewModel{
    let user: User
    var fullname: String {
        return user.fullname
    }
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)!
    }
    var fallowButtonText: String{
        return user.isCurrentUser ? "Edit Profile" : user.isFollowed ? "Following": "Follow"
    }
    var followButtonBackgroundColor: UIColor{
        return user.isCurrentUser ? .white : .systemBlue
    }
    var followButtontextColor: UIColor{
        return user.isCurrentUser ? .black : .white
    }
    init(user: User) {
        self.user = user
    }
}
