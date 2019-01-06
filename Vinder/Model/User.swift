//
//  User.swift
//  Vinder
//
//  Created by Victor Chang on 27/12/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

struct User {
    
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    
    func toCardViewModer() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        attributedText.append(NSAttributedString(string: "\n \(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageName: imageName, attributedString: attributedText, textAlignment: .left)
    }
    
}
