//
//  CommentInputAccessoryView.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 7.11.2022.
//

import UIKit
protocol CommentAccesoryViewDelegate: AnyObject {
    func inputView(_ inputView: CommentInputAccesoryView, watsToUploadComment comment: String)
}
class CommentInputAccesoryView: UIView {
    // MARK: - Properties
    weak var delegate: CommentAccesoryViewDelegate?
    private let commentTextView: InputTextView = {
        let textView = InputTextView()
        textView.placeholdertext = "Enter comment.."
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isScrollEnabled = false
        textView.placeholderShouldCenter = true
        return textView
    }()
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleCommentUpload), for: .touchUpInside)
        return button
    }()
    private let divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .lightGray
        return divider
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize{
        return .zero
    }
}
// MARK: - Helpers
extension CommentInputAccesoryView{
    private func style(){
        autoresizingMask = .flexibleHeight
        backgroundColor = .white
        //postButton style
        postButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(postButton)
        //commentTextView style
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(commentTextView)
        //divider style
        divider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(divider)
    }
    private func layout(){
        //postButton layout
        NSLayoutConstraint.activate([
            postButton.heightAnchor.constraint(equalToConstant: 50),
            postButton.widthAnchor.constraint(equalToConstant: 50),
            postButton.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: postButton.trailingAnchor, constant: 8)
        ])
        //commentTextView layout
        NSLayoutConstraint.activate([
            commentTextView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            commentTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 8),
            postButton.leadingAnchor.constraint(equalTo: commentTextView.trailingAnchor, constant: 8)
        ])
        //divider layout
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 0.5),
            divider.topAnchor.constraint(equalTo: topAnchor),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: divider.trailingAnchor)
        ])
    }
     func clearCommentTextView(){
        commentTextView.text = nil
        commentTextView.placeHolderLabel.isHidden = false
    }
}
// MARK: - Selector
extension CommentInputAccesoryView{
    @objc private func handleCommentUpload(_ sender: UIButton){
        delegate?.inputView(self, watsToUploadComment: commentTextView.text)
    }
}
