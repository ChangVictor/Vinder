//
//  RegistrationViewModel.swift
//  Vinder
//
//  Created by Victor Chang on 14/01/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class RegistrationViewModel {
    
    var bindableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()

    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email , password: password) { (res, error) in
            
            if let error = error {
                completion(error)
                return
            }
            
            print("Succesfully registered user: ", res?.user.uid ?? "")
            
            self.saveImageToFirebase(completion: completion)
            
            // Only upload images to Firebase Storage once you are authorized
           
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        ref.putData(imageData, metadata: nil, completion: { (_, err) in
            
            if let err = err {
                completion(err)
                return // bail out of code
            }
            
            print("Finished uploading image to storage")
            ref.downloadURL(completion: { (url, err) in
                if let err = err {
                    completion(err)
                    return
                }
                
                self.bindableIsRegistering.value = false
                print("downloadURL of image:", url?.absoluteString ?? "not set")
                // Store the download url into Firestore
                
                let imageUrl = url?.absoluteString ?? ""
                self.saveIntoFirestore(imageUrl: imageUrl, completion: completion)
            })
        })
    }
    
    fileprivate func saveIntoFirestore(imageUrl: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName": fullName ?? "", "uid": uid, "imageUrl1": imageUrl]
        Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
            if let err = err {
                completion(err)
                return
            }
            completion(nil)
        }
    }
}
