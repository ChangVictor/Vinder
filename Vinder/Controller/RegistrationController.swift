//
//  RegistrationController.swift
//  Vinder
//
//  Created by Victor Chang on 10/01/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        registrationViewModel.bindableImage.value = image
//        registrationViewModel.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

class RegistrationController: UIViewController {

    // UI Components
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    lazy var selectPhotoButtonWidthAnchor = selectPhotoButton.widthAnchor.constraint(equalToConstant: 275)
    lazy var selectPhotoHeightAnchor = selectPhotoButton.heightAnchor.constraint(equalToConstant: 275)
    
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 50)
        tf.placeholder = "Enter full name"
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    let emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 50)
        tf.placeholder = "Enter email"
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: 24, height: 50)
        tf.placeholder = "Enter password"
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        
        if textField == fullNameTextField {
            registrationViewModel.fullName = textField.text
        } else if textField == emailTextField {
            registrationViewModel.email = textField.text
        } else {
            registrationViewModel.password = textField.text
        }
    }
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
//        button.backgroundColor = #colorLiteral(red: 0.8142727017, green: 0.09650861472, blue: 0.3355827034, alpha: 1)
        button.backgroundColor = .lightGray
        button.setTitleColor(.darkGray, for: .disabled)
        button.isEnabled = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let registeringHUD = JGProgressHUD(style: .dark)
    
    @objc fileprivate func handleRegister() {
        print("Register user in Firebase")
        
        self.handleTapDismiss()
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        registrationViewModel.bindableIsRegistering.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, error) in
            
            if let error = error {
                print(error)
                self.showHUDWithError(error: error)
                return
            }
            
            print("Succesfully registered user: ", res?.user.uid ?? "")
            
            // Only upload images to Firebase Storage once you are authorized
            let filename = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(filename)")
            let imageData = self.registrationViewModel.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            ref.putData(imageData, metadata: nil, completion: { (_, err) in
                
                if let err = err {
                    self.showHUDWithError(error: err)
                    return // bail out of code
                }
                
                print("Finished uploading image to storage")
                ref.downloadURL(completion: { (url, errr) in
                    if let err = err {
                        self.showHUDWithError(error: err)
                        return
                    }
                    
                    self.registrationViewModel.bindableIsRegistering.value = false
                    print("downloadURL of image:", url?.absoluteString ?? "not set")
                    // Store the download url into Firestore
                })
            })
        }
    }
    
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        setupNotificationObservers()
        setupTapGesture()
        
        setupRegistrationViewModelObserver()
        
    }

    // MARK:- Private
    
    let registrationViewModel = RegistrationViewModel()
    
    fileprivate func setupRegistrationViewModelObserver() {
        registrationViewModel.bindableIsFormValid.bind { [unowned self] (isFormValid) in
            
            guard let isFormValid = isFormValid else { return }
            
            self.registerButton.isEnabled = isFormValid
            if isFormValid {
                self.registerButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
                self.registerButton.setTitleColor(.white, for: .normal)
            } else {
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.gray, for: .normal)
            }
        }
        
        registrationViewModel.bindableImage.bind { [unowned self] (img) in
            self.selectPhotoButton.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        registrationViewModel.bindableIsRegistering.bind { [unowned self] (isRegistering) in
            if isRegistering == true {
                self.registeringHUD.textLabel.text = "Register"
                self.registeringHUD.show(in: self.view)
            } else {
                self.registeringHUD.dismiss()
            }
        }
    }

    fileprivate func setupTapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss() {
        self.view.endEditing(true)
        
    }
    
    fileprivate func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // to avoid retain cycles
//        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc fileprivate func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
 
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        print(keyboardFrame)
        
        let bottomSpace = view.frame.height - overrallStackView.frame.origin.y - overrallStackView.frame.height
        print(bottomSpace)
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailTextField,
            passwordTextField,
            registerButton
            ])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var overrallStackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        verticalStackView
        ])
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            overrallStackView.axis = .horizontal
            verticalStackView.distribution = .fillEqually
            selectPhotoHeightAnchor.isActive = false
            selectPhotoButtonWidthAnchor.isActive = true
        } else {
            overrallStackView.axis = .vertical
            verticalStackView.distribution = .fill
            selectPhotoButtonWidthAnchor.isActive = false
            selectPhotoHeightAnchor.isActive = true
        }
    }

    fileprivate func setupLayout() {
        
        view.addSubview(overrallStackView)
        
        overrallStackView.axis = .vertical
        overrallStackView.spacing = 8
        selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
        overrallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        
        overrallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let gradientLayer = CAGradientLayer()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func setupGradientLayer() {
        
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
        
    }


}
