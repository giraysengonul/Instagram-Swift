//
//  LoginController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 15.08.2022.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - PROPERTIES
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Instagram_logo_white")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let emailTextField : UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.keyboardAppearance = .dark
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.borderStyle = .none
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7)])
        return textField
    }()
    private let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.keyboardAppearance = .dark
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.borderStyle = .none
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor : UIColor(white: 1, alpha: 0.7)])
        textField.isSecureTextEntry = true
        return textField
    }()
    private var stackView = UIStackView()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 7
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        return button
    }()
    private let forgotPasswordButton : UIButton = {
        let button = UIButton(type: .system)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        let boldAttributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "Forgot your password?", attributes: attributes)
        attributedTitle.append(NSAttributedString(string: "  help signing in.", attributes: boldAttributes))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    private let dontHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.systemFont(ofSize: 16)]
        let boldAttributes: [NSAttributedString.Key: Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7), .font: UIFont.boldSystemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?", attributes: attributes)
        attributedTitle.append(NSAttributedString(string: " Sign Up", attributes: boldAttributes))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}

// MARK: - HELPERS
extension LoginController{
    private func setup(){
        navigationController?.navigationBar.barStyle = .black
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.frame = view.frame
        gradient.locations = [0,1]
        view.layer.addSublayer(gradient)
        //iconImageView Setup
        view.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        //stackView Setup
        stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton,forgotPasswordButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //dontHaveAccountButton Setup
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        //iconImageView Layout
        NSLayoutConstraint.activate([
            iconImage.heightAnchor.constraint(equalToConstant: 80),
            iconImage.widthAnchor.constraint(equalToConstant: 120),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        ])
        //stackView Layout
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
            
        ])
        //dontHaveAccountButton Layout
        NSLayoutConstraint.activate([
            
            dontHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dontHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}
