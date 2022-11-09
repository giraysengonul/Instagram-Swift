//
//  UserService.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.09.2022.
//

import FirebaseFirestore
import FirebaseAuth
typealias FirestoreCompletion = (Error?) -> Void
struct UserService {
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    static func fetchUsers(completion: @escaping([User])-> Void){
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    static func follow(uid: String, completion:@escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    static func unfollow(uid: String, completion:@escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else{ return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void){
        guard let currentUid = Auth.auth().currentUser?.uid else{ return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, error in
            guard let isFollowing = snapshot?.exists else{ return }
            completion(isFollowing)
        }
    }
    static func fetchUserstats(uid: String, completion: @escaping(UserStats) -> Void){
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, error in
            let followers = snapshot?.documents.count ?? 0
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, error in
                let following = snapshot?.documents.count ?? 0
                COLLECTION_POSTS.whereField("ownerUid",isEqualTo: uid).getDocuments { snapshot, error in
                    let posts = snapshot?.documents.count ?? 0
                    completion(UserStats(followers: followers, following: following,posts: posts))
                }
            }
        }
    }
}
