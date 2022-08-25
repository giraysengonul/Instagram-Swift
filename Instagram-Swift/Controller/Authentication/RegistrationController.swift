//
//  RegistrationController.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 15.08.2022.
//


import UIKit

class RegistrationController: UIViewController {
    // MARK: - PROPERTIES
    private var registrationViewModel = RegistrationViewModel()
    private var selectedProfileImage: UIImage?
    private let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "plus_photo")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilPhotoSelect), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
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
        configureNotificationObserves()
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
    func configureNotificationObserves(){
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}
// MARK: - ACTIONS
extension RegistrationController{
    @objc func handleShowLogIn(){
        navigationController?.popViewController(animated: true)
    }
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField{
            registrationViewModel.email = sender.text
        }else if sender == passwordTextField{
            registrationViewModel.password = sender.text
        }else if sender == fullnameTextField{
            registrationViewModel.fullname = sender.text
        }
        else if sender == usernameTextField{
            registrationViewModel.username = sender.text
        }
        updateForm()
    }
    @objc func handleProfilPhotoSelect(_ sender: UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    @objc func handleSignUp(_ sender: UIButton){
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else{ return }
        guard let fullname = fullnameTextField.text else{ return }
        guard let username = usernameTextField.text else{ return }
        guard let profileImage = selectedProfileImage else { return }
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        AuthService.registerUser(withCredential: credentials)
    }
}
// MARK: - FORMMODELVIEW
extension RegistrationController: FormViewModel{
    func updateForm() {
        signUpButton.backgroundColor = registrationViewModel.buttonBackgroundColor
        signUpButton.setTitleColor(registrationViewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = registrationViewModel.formIsValid
    }
}
// MARK: - ImagePickerController
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return  }
        selectedProfileImage = profileImage
        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.clipsToBounds = true
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 2
        dismiss(animated: true)
    }
}
