//
//  InputTextView.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.10.2022.
//

import UIKit
class InputTextView: UITextView {
    // MARK: - Properties
    var placeholdertext: String?{
        didSet{ placeHolderLabel.text = placeholdertext }
    }
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Selector
    @objc func handleTextChange(_ sender: NotificationCenter){
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
// MARK: - Helpers
extension InputTextView{
    private func style(){
        //placeHolderLabel style
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeHolderLabel)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    private func layout(){
        //placeHolderLabel layout
        NSLayoutConstraint.activate([
            placeHolderLabel.topAnchor.constraint(equalTo: topAnchor,constant: 6),
            placeHolderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
}
