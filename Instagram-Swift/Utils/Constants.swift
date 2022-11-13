//
//  Constants.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.09.2022.
//

import FirebaseFirestore

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATION = Firestore.firestore().collection("notifications")
