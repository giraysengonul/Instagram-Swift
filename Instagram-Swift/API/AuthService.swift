//
//  AuthService.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.08.2022.
//
import Foundation
import UIKit
import FirebaseAuth

struct AuthCredentials{
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService{
    
    static func registerUser(withCredential credential: AuthCredentials){
        print(credential)
    }
    
}

