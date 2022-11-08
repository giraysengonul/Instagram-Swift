//
//  CommentCell.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 6.11.2022.
//

import UIKit
class CommentCell: UICollectionViewCell{
    // MARK: - Properties
    var viewModel: CommentViewModel?{
        didSet{ configure() }
    }
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    private let commentLabel = UILabel()
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
        commentLabel.numberOfLines = 0
        commentLabel.lineBreakMode = .byWordWrapping
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
            trailingAnchor.constraint(equalTo: commentLabel.trailingAnchor, constant: 8)
        ])
    }
    private func configure(){
        guard let viewModel = self.viewModel else { return }
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        commentLabel.attributedText = viewModel.commnetLabelText()
    }
}
