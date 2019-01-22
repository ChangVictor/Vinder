//
//  User.swift
//  Vinder
//
//  Created by Victor Chang on 27/12/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

struct User: ProducesCardViewModel {
    
    let name: String
    let age: Int
    let profession: String
    let imageNames: [String]
    
    init(dictionary: [String: Any]) {
        // initialize user here
        let name = dictionary["fullName"] as? String ?? ""
        
        self.age = 0
        self.profession = "Unemployed"
        self.name = name
        
        let imageUrl1 = dictionary["imageUrl1"] as? String ?? ""
        self.imageNames = [imageUrl1]
    }
    
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "  \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        
        attributedText.append(NSAttributedString(string: "\n \(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        
        return CardViewModel(imageNames: imageNames, attributedString: attributedText, textAlignment: .left)
    }
    
}
