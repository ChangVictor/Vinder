//
//  HomeButtonControlsStackView.swift
//  Vinder
//
//  Created by Victor Chang on 25/12/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class HomeButtonControlsStackView: UIStackView {
    
    static func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    let refreshButton = createButton(image: #imageLiteral(resourceName: "tinder_reload"))
    let dislikeButton = createButton(image: #imageLiteral(resourceName: "tinder_cancel"))
    let superLikeButton = createButton(image: #imageLiteral(resourceName: "tinder_star"))
    let likeButton = createButton(image: #imageLiteral(resourceName: "tinder_heart"))
    let specialButton = createButton(image: #imageLiteral(resourceName: "tinder_thunder"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 95).isActive = true
        
        [refreshButton, dislikeButton, superLikeButton, superLikeButton, specialButton].forEach { (button) in
            self.addArrangedSubview(button)
        }
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
