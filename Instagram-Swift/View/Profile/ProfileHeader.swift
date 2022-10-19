//
//  ProfileHeader.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 1.09.2022.
//

import UIKit
import SDWebImage
protocol ProfileHeaderDelegate: AnyObject{
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User)
}
class ProfileHeader: UICollectionReusableView {
    // MARK: - Properties
    var viewModel: ProfileHeaderViewModel?{
        didSet{
            configure()
        }
    }
    weak var delegate: ProfileHeaderDelegate?
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 80 / 2
        return imageView
    }()
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleEditProfileFollowTapped), for: .touchUpInside)
        return button
    }()
    private let stackView = UIStackView()
    private lazy var postsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let topDivider = UIView()
    private let buttonStackView = UIStackView()
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "grid")
        button.setImage(image, for: .normal)
        return button
    }()
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "list")
        button.setImage(image, for: .normal)
        return button
    }()
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "ribbon")
        button.setImage(image, for: .normal)
        return button
    }()
    private let bottomDivider = UIView()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Helpers
extension ProfileHeader{
    private func style(){
        backgroundColor = .white
        //profileImage Style
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImage)
        //nameLabel Style
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        //editProfileFollowButton Style
        editProfileFollowButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(editProfileFollowButton)
        //stackView Style
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        //postsLabel Style
        postsLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(postsLabel)
        //followersLabel Style
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(followersLabel)
        //followingLabel Style
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(followingLabel)
        //topDivider
        topDivider.translatesAutoresizingMaskIntoConstraints = false
        topDivider.backgroundColor = .lightGray
        addSubview(topDivider)
        //bottomStackView
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStackView)
        //gridButton Style
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(gridButton)
        //listButton Style
        listButton.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(listButton)
        //bookmarkButton Style
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(bookmarkButton)
        //bottomDivider
        bottomDivider.translatesAutoresizingMaskIntoConstraints = false
        bottomDivider.backgroundColor = .lightGray
        addSubview(bottomDivider)
    }
    private func layout(){
        //profileImage Layout
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
        //nameLabel Layout
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
        //editProfileFollowButton Layout
        NSLayoutConstraint.activate([
            editProfileFollowButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            editProfileFollowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            trailingAnchor.constraint(equalTo: editProfileFollowButton.trailingAnchor, constant: 24)
        ])
        //stackView Layout
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 12),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        //buttonStackView Layout
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor),
            bottomAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        //topDivider Layout
        NSLayoutConstraint.activate([
            topDivider.topAnchor.constraint(equalTo: buttonStackView.topAnchor),
            topDivider.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: topDivider.trailingAnchor),
            topDivider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        //bottomDivider Layout
        NSLayoutConstraint.activate([
            bottomDivider.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor),
            trailingAnchor.constraint(equalTo: bottomDivider.trailingAnchor),
            bottomDivider.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomDivider.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.fullname
        profileImage.sd_setImage(with: viewModel.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.fallowButtonText, for: .normal)
        editProfileFollowButton.setTitleColor(viewModel.followButtontextColor, for: .normal)
        editProfileFollowButton.backgroundColor = viewModel.followButtonBackgroundColor
        postsLabel.attributedText = viewModel.numberOfPosts
        followersLabel.attributedText = viewModel.numberOfFollowers
        followingLabel.attributedText = viewModel.numberOfFollowing
    }
}
// MARK: - Actions, Selector
extension ProfileHeader{
    @objc func handleEditProfileFollowTapped(_ sender: UIButton){
        guard let viewModel = viewModel else { return  }
        delegate?.header(self, didTapActionButtonFor: viewModel.user)
    }
}
