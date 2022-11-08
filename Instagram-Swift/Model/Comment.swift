//
//  Comments.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 8.11.2022.
//

import Foundation
import FirebaseFirestore
struct Comment {
    let uid: String
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let commentText: String
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.commentText = dictionary["comment"] as? String ?? ""
    }
}
