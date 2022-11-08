//
//  CommentService.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 8.11.2022.
//

import Foundation
import FirebaseFirestore
struct CommentService {
    static func uploadComment(comment: String, postId: String, user: User, completion: @escaping(Error?)-> Void){
        let data: [String: Any] = ["uid": user.uid, "comment": comment, "timestamp": Timestamp(date: Date()), "username": user.username, "profileImageUrl": user.profileImageUrl]
        COLLECTION_POSTS.document(postId).collection("comments").addDocument(data: data,completion: completion)
    }
    static func fetchComments(forPost postID: String, completion: @escaping([Comment])->Void){
        let query = COLLECTION_POSTS.document(postID).collection("comments").order(by: "timestamp", descending: true)
        var comments = [Comment]()
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    let comment = Comment(dictionary: dictionary)
                    comments.append(comment)
                }
            })
            completion(comments)
        }
    }
}
