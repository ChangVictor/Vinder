//
//  Firebase+Utils.swift
//  Vinder
//
//  Created by Victor Chang on 21/02/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Firebase


extension Firestore {
    func fetchCurrentUser(completion: @escaping (User?, Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            //fetched user here
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user, nil)
        }
    }
}
