//
//  RegistrationController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 15.08.2022.
//


import UIKit

class RegistrationController: UIViewController {
    // MARK: - PROPERTIES
    private let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "plus_photo")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    private let emailTextField : UITextField = {
        let textField = CustomTextField(placeHolder: "Email")
        textField.keyboardType = .emailAddress
        textField.keyboardAppearance = .dark
        return textField
    }()
    private let passwordTextField : UITextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    private let fullnameTextField = CustomTextField(placeHolder: "Fullname")
    
    private let usernameTextField = CustomTextField(placeHolder: "Username")
    
    private var stackView = UIStackView()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.loginAndRegisterButton(withSetTitle: "Sign Up")
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    private let alreadyHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(withFirstPart: "Already have an account?", withSecondPart: "Log In")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
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
extension RegistrationController{
    private func setup(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        configureGradientLayer()
        //plusPhotoButton Setup
        view.addSubview(plusPhotoButton)
        plusPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        //stackView
        stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,fullnameTextField,usernameTextField,signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //dontHaveAccountButton Setup
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        //plusPhotoButton Layout
        NSLayoutConstraint.activate([
            
            plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plusPhotoButton.heightAnchor.constraint(equalToConstant: 140),
            plusPhotoButton.widthAnchor.constraint(equalToConstant: 140),
            plusPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 32)
            
        ])
        //stackView Layout
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
            
        ])
        //dontHaveAccountButton Layout
        NSLayoutConstraint.activate([
            
            alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}
// MARK: - ACTIONS
extension RegistrationController{
    @objc func handleShowLogIn(){
        navigationController?.popViewController(animated: true)
    }
}
