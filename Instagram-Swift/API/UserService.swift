//
//  UserService.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.09.2022.
//

import FirebaseFirestore
import FirebaseAuth

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
