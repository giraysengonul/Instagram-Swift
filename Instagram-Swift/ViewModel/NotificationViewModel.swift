//
//  NotificationViewModel.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 14.11.2022.
//

import UIKit
struct NotificationViewModel {
    let notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    var postImageUrl: URL?{ return URL(string: notification.postImageUrl ?? "") }
    var profileImageUrl: URL?{ return URL(string: notification.userProfileImageUrl) }
    var notificationMessage: NSAttributedString?{
        let username = notification.username
        let message = notification.type.notificationMessage
        let attributedText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: " 2m", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
    var shouldHidePostImage: Bool{ return self.notification.type == .follow }
    var followButtonText: String { return notification.userIsFollowed ? "Following" : "Follow"}
    var followButtonBackgroundColor: UIColor { return notification.userIsFollowed ? .white : .systemBlue}
    var followButtonTextColor: UIColor { return notification.userIsFollowed ? .black : .white }
}
