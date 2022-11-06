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
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}
// MARK: - Helpers
extension CommentController{
    private func setup(){
        collectionView.backgroundColor = .white
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        cell.backgroundColor = .red
        return cell
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}
