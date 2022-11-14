//
//  Notification.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 13.11.2022.
//

import FirebaseFirestore

enum NotificationType: Int {
    case like
    case follow
    case comment
    var notificationMessage: String{
        switch self {
        case .like:
            return " like your post."
        case .follow:
            return " started following you."
        case .comment:
            return " commented on your post."
        }
    }
}
struct Notification{
    let uid: String
    var postImageUrl: String?
    var postId: String?
    let timestamp: Timestamp
    let type: NotificationType
    let id: String
    
    init(dictionary: [String : Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.postImageUrl =  dictionary["postImageUrl"] as? String ?? ""
        self.postId =  dictionary["postId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? ""
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
    }
}
