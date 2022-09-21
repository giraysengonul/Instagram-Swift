//
//  AuthService.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.08.2022.
//
import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials{
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService{
    
    static func logUserIn(withEmail email: String, withPassword password: String, completion: @escaping (AuthDataResult?, Error?)-> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    static func registerUser(withCredential credential: AuthCredentials, completion: @escaping(Error?) -> Void){
        ImageUploader.uploadImage(images: credential.profileImage) { url in
            Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
                if let error = error {
                    print("Failed to register user \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else{ return }
                let data: [String : Any] = ["email": credential.email,
                                            "fullname":credential.fullname,
                                            "profileImageUrl": url,
                                            "uid": uid,
                                            "username": credential.username
                ]
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
    
}

