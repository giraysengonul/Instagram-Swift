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
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let view = CommentInputAccesoryView(frame: frame)
        view.delegate = self
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
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
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}
 // MARK: - CommentAccesoryViewDelegate
extension CommentController: CommentAccesoryViewDelegate{
    func inputView(_ inputView: CommentInputAccesoryView, watsToUploadComment comment: String) {
        inputView.clearCommentTextView()
    }
}
