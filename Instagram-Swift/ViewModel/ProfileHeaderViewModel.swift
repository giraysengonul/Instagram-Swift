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
    var numberOfFollowers: NSAttributedString{
        return attributedStatText(value: user.stats.followers, label: "followers")
    }
    var numberOfFollowing: NSAttributedString{
        return attributedStatText(value: user.stats.following, label: "following")
    }
    var numberOfPosts: NSAttributedString{
        return attributedStatText(value: 5, label: "posts")
    }
    init(user: User) {
        self.user = user
    }
    func attributedStatText(value: Int, label: String) -> NSMutableAttributedString{
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.systemFont(ofSize: 14, weight: .bold)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font : UIFont.systemFont(ofSize: 14, weight: .medium), .foregroundColor : UIColor.lightGray]))
        return attributedText
    }
}
