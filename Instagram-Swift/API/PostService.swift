//
//  PostService.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 28.10.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct PostService{
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        ImageUploader.uploadImage(images: image) { imageUrl in
            let data = ["caption": caption, "timestamp": Timestamp(date: Date()), "likes": 0, "imageUrl": imageUrl, "ownerUid": uid] as [String: Any]
            COLLECTION_POSTS.addDocument(data: data,completion: completion)
        }
    }
    static func fetchPosts(completion: @escaping([Post])-> Void){
        COLLECTION_POSTS.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else{ return }
            let posts = documents.map({Post(postId: $0.documentID, dictionary: $0.data())})
            completion(posts)
        }
    }
}
