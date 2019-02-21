//
//  LoginViewModel.swift
//  Vinder
//
//  Created by Victor Chang on 21/02/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation
import Firebase

class LoginViewModel {
    
    var isLogginIn = Bindable<Bool>()
    var isFormValid = Bindable<Bool>()
    
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isValid = email?.isEmpty == false && password?.isEmpty == false
        isFormValid.value = isValid
    }
    
    func performLogin(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        isLogginIn.value = true
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            completion(error)
        }
    }
    
}
