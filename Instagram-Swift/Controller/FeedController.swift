//
//  FeedController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 13.08.2022.
//

import UIKit
import FirebaseAuth
private let reuseIdentifier = "Cell"
class FeedController: UICollectionViewController {
    // MARK: - PROPERTIES
    private var posts: [Post]? {
        didSet{ self.collectionView.reloadData() }
    }
    var post: Post?
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        fetchPosts()
    }
    // MARK: - API
    private func fetchPosts(){
        guard post == nil else { return }
        PostService.fetchPosts { posts in
            self.posts = posts
            self.checkIfUserLikePost()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    private func checkIfUserLikePost(){
        self.posts?.forEach({ post in
            PostService.checkIfUserLikedPost(post: post) { didLike in
                if let index = self.posts?.firstIndex(where: { $0.postId == post.postId }){
                    self.posts?[index].didLike = didLike
                }
            }
        })
    }
}
// MARK: - HELPERS
extension FeedController{
    private func setup(){
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        if post == nil{
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
            navigationItem.title = "Feed"
        }
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    private func layout(){
        
    }
}
// MARK: - UICollectionViewDataSource
extension FeedController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let posts = posts else{ return 1 }
        return post == nil ? posts.count : 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.delegate = self
        if let post = post{
            cell.viewModel = PostViewModel(post: post)
        }else{
            guard let posts = posts else { return cell }
            cell.viewModel = PostViewModel(post: posts[indexPath.row]) }
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension FeedController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        return CGSize(width: width, height: height)
    }
}
// MARK: - Actions
extension FeedController{
    @objc private func handleLogout(_ sender: UIBarButtonItem){
        do{
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }catch{
            print("Failed to sign out")
        }
    }
    @objc func handleRefresh(){
        posts?.removeAll()
        fetchPosts()
    }
}
// MARK: - FeedCellDelegate
extension FeedController: FeedCellDelegate{
    func cell(_ cell: FeedCell, watsToShowProfileFor uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func cell(_ cell: FeedCell, WantsToShowCommentsFor post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    func cell(_ cell: FeedCell, didLike post: Post) {
        guard let tab = tabBarController as? MainController else { return }
        guard let user = tab.user else { return }
        cell.viewModel?.post.didLike.toggle()
        if post.didLike{
            PostService.unlikePost(post: post) { _ in
                let image = #imageLiteral(resourceName: "like_unselected")
                cell.likeButton.setImage(image, for: .normal)
                cell.likeButton.tintColor = .black
                cell.viewModel?.post.likes = post.likes - 1
            }
        }else{
            PostService.likePost(post: post) { error in
                let image = #imageLiteral(resourceName: "like_selected")
                cell.likeButton.setImage(image, for: .normal)
                cell.likeButton.tintColor = .red
                cell.viewModel?.post.likes = post.likes + 1
                NotificationService.uploadNotification(toUid: post.ownerUid,fromUser: user, type: .like,post: post)
            }
        }
    }
}
