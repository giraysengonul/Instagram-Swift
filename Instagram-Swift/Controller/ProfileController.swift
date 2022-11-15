//
//  ProfileController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 13.08.2022.
//


import UIKit
private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"
class ProfileController: UICollectionViewController {
    // MARK: - PROPERTIES
    private var user: User
    private var posts = [Post]()
    // MARK: - LIFECYCLE
    init(user:User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        checkIsUserIsFollowed()
        fetchUserStats()
        fetchPosts()
    }
    // MARK: - API
    private func checkIsUserIsFollowed(){
        UserService.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    private func fetchUserStats(){
        UserService.fetchUserstats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
}
// MARK: - HELPERS
extension ProfileController{
    private func setup(){
        navigationItem.title = user.username
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    private func layout(){
        
    }
    func fetchPosts(){
        PostService.fetchPosts(forUser: user.uid) { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
}
// MARK: - UICollectionViewDataSource and UICollectionViewDelegate
extension ProfileController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        header.viewModel = ProfileHeaderViewModel(user: user)
        header.delegate = self
        return header
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = self.posts[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}
// MARK: - ProfileHeaderDelegate
extension ProfileController: ProfileHeaderDelegate{
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        guard let tab = tabBarController as? MainController else{ return }
        guard let currentUser = tab.user else { return }
        if user.isCurrentUser{
            
        }else if user.isFollowed {
            UserService.unfollow(uid: user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        }else{
            UserService.follow(uid: user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
                NotificationService.uploadNotification(toUid: user.uid, fromUser: currentUser, type: .follow)
            }
        }
    }
}
