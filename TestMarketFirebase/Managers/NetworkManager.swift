//
//  NetworkManager.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

struct ResponseCode {
    let code: Int
    let error: Error?
}


final class NetworkManager {
    static let shared = NetworkManager()
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
//    func getPost(collections: String, docName: String, completion: @escaping (Document?) -> Void) {
//        let db = configureFB()
//        db.collection(collections).document(docName).getDocument(completion: { (document, error) in
//            guard error == nil else { completion(nil); return }
//            let doc = Document(field1: document?.get("field1") as! String, field2: document?.get("field2") as! String)
//            completion(doc)
//        })
//    }
//    
//    func getImage(picName: String, completion: @escaping (UIImage) -> Void) {
//        let storage = Storage.storage()
//        let reference = storage.reference()
//        let pathRef = reference.child("pictures")
//        
//        var image: UIImage = UIImage(named: "default_pic")!
//        
//        let fileRef = pathRef.child(picName + ".jpg")
//        fileRef.getData(maxSize: 1024*1024, completion: { (data, error) in
//            guard error == nil else { completion(image); print(error?.localizedDescription); return}
//            image = UIImage(data: data!)!
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        })
//    }
    
    func createNewUser(email: String, password: String, completion: @escaping (ResponseCode)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                let userId = result?.user.uid
                let data: [String: Any] = ["email":email]
                
                Firestore.firestore().collection("users").document(userId!).setData(data)
                completion(ResponseCode(code: 1, error: nil))
            } else {
                completion(ResponseCode(code: 0, error: error))
            }
        }
    }
    
    func confirmMail(completion: @escaping (Error?) -> ()) {
        Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                completion(error)
        })
    }
    
    func signIn(email: String, password: String, completion: @escaping (ResponseCode)->Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error == nil {
                completion(ResponseCode(code: 1, error: nil))
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}
