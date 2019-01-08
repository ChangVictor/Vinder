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
    
    let cardViewModels: [CardViewModel] = {
        let producers = [
                
            User(name: "Dua Lipa", age: 23, profession: "Singer", imageNames: ["dua1", "dua2", "dua3"]),
                User(name: "Hailey Baldwin", age: 22, profession: "Model", imageNames: ["hailey1", "hailey2", "hailey3"]),
                User(name: "Victor Chang", age: 28, profession: "iOS Developer", imageNames: ["victor1"]),
                
                Advertiser(title: "iOS Development", brandName: "Victor Chang", posterPhotoName: "macbookPro")
    
        ] as [ProducesCardViewModel]
        
        let viewModels = producers.map({return $0.toCardViewModel()})
        return viewModels
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupDummyCards()
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

