//
//  CustomTextField.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 17.08.2022.
//

import UIKit

class CustomTextField: UITextField {
    private let placeHolderNew: String
    init(placeHolder: String) {
        placeHolderNew = placeHolder
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CustomTextField{
    private func setup(){
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        spacer.widthAnchor.constraint(equalToConstant: 12).isActive = true
        leftView = spacer
        leftViewMode = .always
        keyboardType = .emailAddress
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        borderStyle = .none
        textColor = .white
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        attributedPlaceholder = NSAttributedString(string: placeHolderNew, attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.87)])
        
        
    }
}
