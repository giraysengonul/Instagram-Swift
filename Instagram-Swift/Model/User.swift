//
//  User.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.09.2022.
//

import Foundation
import FirebaseAuth
struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    var isFollowed = false
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    init(dictionary: [String : Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}