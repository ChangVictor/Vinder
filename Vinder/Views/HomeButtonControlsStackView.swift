//
//  HomeButtonControlsStackView.swift
//  Vinder
//
//  Created by Victor Chang on 25/12/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class HomeButtonControlsStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 95).isActive = true
        
        let subviews = [#imageLiteral(resourceName: "tinder_reload"), #imageLiteral(resourceName: "tinder_cancel"), #imageLiteral(resourceName: "tinder_star"), #imageLiteral(resourceName: "tinder_heart"), #imageLiteral(resourceName: "tinder_thunder")].map { (image) -> UIView in
            let button = UIButton(type: .system)
            button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
            return button
        }
        subviews.forEach { (view) in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
