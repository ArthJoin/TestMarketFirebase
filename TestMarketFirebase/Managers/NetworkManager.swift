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

struct ProductItem {
    let image: String
    let name: String
    let discription: String
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
    
    func getProduct(collections: String, completion: @escaping ([ProductItem]) -> Void) {
        let db = configureFB()
        var result: [ProductItem] = []
        db.collection(collections).getDocuments { querySnapshot, error in
            if let error = error {
                print("Ошибка при получении документов: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else { return }
                for doc in documents {
                    let data = doc.data()
                    if let imageId = data["imageId"] as? String,
                       let name = data["productName"] as? String,
                       let discr = data["productDescr"] as? String {
                        result.append(ProductItem(image: imageId, name: name, discription: discr))
                    }
                }
                completion(result)
            }
        }
    }
 
    func getImage(picName: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("products")
        
        var image: UIImage = UIImage(named: "default_pic")!
        
        let fileRef = pathRef.child(picName + ".webp")
        fileRef.getData(maxSize: 1024*1024, completion: { (data, error) in
            guard error == nil else { completion(image); print(error?.localizedDescription); return}
            image = UIImage(data: data!)!
            DispatchQueue.main.async {
                completion(image)
            }
        })
    }
    
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
                if let result = result {
                    if result.user.isEmailVerified {
                        completion(ResponseCode(code: 1, error: nil))
                    } else {
                        self.confirmMail { error in
                            print("Сonfirm Mail")
                        }
                    }
                }
            } else {
                completion(ResponseCode(code: 0, error: error))
            }
        }
    }
}
