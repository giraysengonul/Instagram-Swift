//
//  AuthenticationViewModel.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 18.08.2022.
//

import Foundation
import UIKit

struct LoginViewModel{
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


struct RegistrationViewModel {
    
}
