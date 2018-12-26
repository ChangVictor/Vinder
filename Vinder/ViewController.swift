//
//  ViewController.swift
//  Vinder
//
//  Created by Victor Chang on 25/12/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let buttonStackView = HomeButtonControlsStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        setupDummyCards()
    }

    //MARK:- Fileprivate
    
    fileprivate func setupDummyCards() {
        print("Settring dummy cards...")
        let cardView = CardView(frame: .zero)
        cardsDeckView.addSubview(cardView)
        cardView.fillSuperview()
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

