//
//  HomeController.swift
//  Vinder
//
//  Created by Victor Chang on 25/12/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonStackView = HomeButtonControlsStackView()
    
//    let users = [
//        User(name: "Dua Lipa", age: 23, profession: "Singer", imageName: "dua1"),
//        User(name: "Hailey Baldwin", age: 22, profession: "Model", imageName: "hailey1")
//    ]
    
    let cardViewModels = [
    
        User(name: "Dua Lipa", age: 23, profession: "Singer", imageName: "dua1").toCardViewModer(),
        User(name: "Hailey Baldwin", age: 22, profession: "Model", imageName: "hailey1").toCardViewModer()
        
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupDummyCards()
    }

    //MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: cardVM.imageName)
            cardView.informationLabel.attributedText = cardVM.attributedString
            cardView.informationLabel.textAlignment = cardVM.textAlignment
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
//        users.forEach { (user) in
//            let cardView = CardView(frame: .zero)
//            cardView.imageView.image = UIImage(named: user.imageName)
//            cardView.informationLabel.text = "\(user.name) \(user.age) \n\(user.profession)"
//
//            let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
//            attributedText.append(NSAttributedString(string: "  \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
//
//            attributedText.append(NSAttributedString(string: "\n \(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
//
//
//            cardView.informationLabel.attributedText = attributedText
//
//            cardsDeckView.addSubview(cardView)
//            cardView.fillSuperview()
//        }
    }
    
    fileprivate func setupLayout() {
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

