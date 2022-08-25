//
//  Imageuploader.swift
//  Instagram-Swift
//
//  Created by hakkı can şengönül on 21.08.2022.
//

import FirebaseStorage

struct ImageUploader {
    static func uploadImage(images: UIImage, completion: @escaping(String) -> Void){
        guard let imageData = images.jpegData(compressionQuality: 0.75) else { return }
        let fileName = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName).jpg")
        ref.putData(imageData,metadata: nil) { metadata, error in
            if error != nil {
                print("DEBUG: Failed to upload image")
                return
            }
            ref.downloadURL { url, error in
                if error == nil{
                    guard let imageUrl = url?.absoluteString else{return}
                    completion(imageUrl)
                }
            }
        }
        
        
        
    }
}
