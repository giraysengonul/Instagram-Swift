//
//  CommentViewModel.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 8.11.2022.
//

import UIKit
struct CommentViewModel {
    private let comment: Comment
    
    var profileImageUrl: URL?{ return URL(string: comment.profileImageUrl) }
    
    init(comment: Comment) {
        self.comment = comment
    }
    func commnetLabelText() -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: "\(comment.username) ",attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "\(comment.commentText)", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        return attributedString
    }
    func size(forWidth width: CGFloat) -> CGSize{
        let label = UILabel()
        label.text = comment.commentText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: width).isActive = true
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
