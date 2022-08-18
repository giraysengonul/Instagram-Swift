//
//  AuthenticationViewModel.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 18.08.2022.
//

import Foundation
import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonTitleColor: UIColor { get }
    var buttonBackgroundColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel{
    var email : String?
    var password: String?
    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false
    }
    var buttonBackgroundColor: UIColor{
        return formIsValid ? .systemBlue : .systemPurple.withAlphaComponent(0.5)
    }
    var buttonTitleColor: UIColor{
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.65)
    }
}


struct RegistrationViewModel: AuthenticationViewModel{
    
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool{
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonTitleColor: UIColor{
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.65)
    }
    
    var buttonBackgroundColor: UIColor{
        return formIsValid ? .systemBlue : .systemPurple.withAlphaComponent(0.5)
    }
    
}
