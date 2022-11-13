//
//  NotificationCell.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 13.11.2022.
//

import UIKit
class NotificationCell: UITableViewCell {
    // MARK: - Properties
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Hakkı"
        return label
    }()
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePostTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    private lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension NotificationCell{
    private func setup(){
        selectionStyle = .none
        //profileImage setup
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImage)
        //infoLabel setup
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(infoLabel)
        //followButton setup
        followButton.isHidden = true
        followButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(followButton)
        //postImageView setup
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(postImageView)
    }
    private func layout(){
        //profileImage layout
        profileImage.layer.cornerRadius = 48 / 2
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 48),
            profileImage.widthAnchor.constraint(equalToConstant: 48),
            profileImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
        //infoLabel layout
        NSLayoutConstraint.activate([
            infoLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8)
        ])
        //followButton layout
        NSLayoutConstraint.activate([
            followButton.heightAnchor.constraint(equalToConstant: 32),
            followButton.widthAnchor.constraint(equalToConstant: 100),
            followButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: followButton.trailingAnchor, constant: 12)
        ])
        //postImageView layout
        NSLayoutConstraint.activate([
            postImageView.widthAnchor.constraint(equalToConstant: 40),
            postImageView.heightAnchor.constraint(equalToConstant: 40),
            postImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 12)
        ])
    }
}
// MARK: - Selector
extension NotificationCell{
    @objc private func handleFollowTapped(_ sender: UIButton){
        
    }
    @objc private func handlePostTapped(){
        
    }
}
