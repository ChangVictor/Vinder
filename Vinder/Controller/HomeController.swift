//
//  HomeController.swift
//  Vinder
//
//  Created by Victor Chang on 25/12/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonStackView = HomeButtonControlsStackView()
    
//    let cardViewModels: [CardViewModel] = {
//        let producers = [
//
//            User(name: "Dua Lipa", age: 23, profession: "Singer", imageNames: ["dua1", "dua2", "dua3"]),
//                User(name: "Hailey Baldwin", age: 22, profession: "Model", imageNames: ["hailey1", "hailey2", "hailey3"]),
//                User(name: "Victor Chang", age: 28, profession: "iOS Developer", imageNames: ["victor1"]),
//
//                Advertiser(title: "iOS Development", brandName: "Victor Chang", posterPhotoName: "macbookPro")
//
//        ] as [ProducesCardViewModel]
//
//        let viewModels = producers.map({return $0.toCardViewModel()})
//        return viewModels
//    }()

    var cardViewModels = [CardViewModel]() // Empty array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        setupLayout()
        setupDummyCards()
        fetchUsersFromFirestore()
    }
    
    fileprivate func fetchUsersFromFirestore() {
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            
            if let error = error  {
                print("Failed to fecth user: ", error)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModels.append(user.toCardViewModel())
            })
            self.setupDummyCards()
        }
    }
    
    @objc func handleSettings() {
        
        print("Show registration page...")
        let registrationController = RegistrationController()
        present(registrationController, animated: true, completion: nil)
    }

    //MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            
            cardView.cardViewModel = cardVM
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.frame = .init(x: 0, y: 0, width: 300, height: 200)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }

}

