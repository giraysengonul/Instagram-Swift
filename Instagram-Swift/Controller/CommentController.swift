//
//  CommentController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 6.11.2022.
//

import UIKit
private let reuseIdentifier = "CommentCell"
class CommentController: UICollectionViewController {
    // MARK: - Properties
    private let post: Post
    private var comments = [Comment]()
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CommentInputAccesoryView(frame: frame)
        view.delegate = self
        return view
    }()
    // MARK: - Lifecycle
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        fetchComments()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    override var inputAccessoryView: UIView?{
        get{ return commentInputView }
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }
}
// MARK: - API
extension CommentController{
    func fetchComments() {
        CommentService.fetchComments(forPost: post.postId) { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
}
// MARK: - Helpers
extension CommentController{
    private func setup(){
        collectionView.backgroundColor = .white
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        navigationItem.title = "Comments"
    }
    private func layout(){
        
    }
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension CommentController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = comments[indexPath.row].uid
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height + 32
        return CGSize(width: view.frame.width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 12)
    }
}
// MARK: - CommentAccesoryViewDelegate
extension CommentController: CommentAccesoryViewDelegate{
    func inputView(_ inputView: CommentInputAccesoryView, watsToUploadComment comment: String) {
        guard let tabController = self.tabBarController as? MainController else{ return }
        guard let user = tabController.user else { return }
        showLoader(true)
        CommentService.uploadComment(comment: comment, postId: post.postId, user: user) { error in
            inputView.clearCommentTextView()
            self.showLoader(false)
        }
    }
}
