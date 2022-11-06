//
//  FeedCell.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 14.08.2022.
//

import UIKit
protocol FeedCellDelegate: AnyObject{
    func cell(_ cell: FeedCell, WantsToShowCommentsFor post: Post)
}
class FeedCell: UICollectionViewCell {
    // MARK: - PROPERTIES
    var viewModel: PostViewModel?{
        didSet{ configure() }
    }
    weak var delegate: FeedCellDelegate?
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "like_unselected")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "comment")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
        return button
    }()
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "send2")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        return button
    }()
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2 days ago"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .lightGray
        return label
    }()
    private var stackView = UIStackView()
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setup()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - HELPERS
extension FeedCell{
    private func setup(){
        //profileImageView Setup
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 40 / 2
        //usernameButton Setup
        addSubview(usernameButton)
        usernameButton.translatesAutoresizingMaskIntoConstraints = false
        //postImageView Setup
        addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        //stackView Setup
        stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //likesLabel Setup
        addSubview(likesLabel)
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        //captionalLabel Setup
        addSubview(captionLabel)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        //postTimeLabel Setup
        addSubview(postTimeLabel)
        postTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        //profileImageView Layout
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 12),
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
        //usernameButton Layout
        NSLayoutConstraint.activate([
            usernameButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            usernameButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8)
        ])
        //postImageView Layout
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: widthAnchor)
        ])
        //stackView Layout
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: postImageView.bottomAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 50),
        ])
        //likesLabel Layout
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 4),
            likesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        //captionalLabel Layout
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 4),
            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        //postTimeLabel Layout
        NSLayoutConstraint.activate([
            postTimeLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 4),
            postTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    private func configure(){
        guard let viewModel = viewModel else{ return }
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
        likesLabel.text = viewModel.likesLabelText
    }
}
// MARK: - ACTIONS
extension FeedCell {
    @objc func didTapUsername(){
        print("did tap username")
    }
    @objc func didTapComments(_ sender: UIButton){
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, WantsToShowCommentsFor: viewModel.post)
    }
}
