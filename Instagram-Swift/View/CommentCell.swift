//
//  CommentCell.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 6.11.2022.
//

import UIKit
class CommentCell: UICollectionViewCell{
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    private let commentLabel : UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Hakki ",attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: "Some test Comment For Now...", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedString
        return label
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension CommentCell{
    private func setup(){
        //profileImageView setup
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)
        //commentLabel setup
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentLabel)
    }
    private func layout(){
        //profileImageView layout
        profileImageView.layer.cornerRadius = 40 / 2
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        //commentLabel layout
        NSLayoutConstraint.activate([
            commentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor,
                                                  constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
