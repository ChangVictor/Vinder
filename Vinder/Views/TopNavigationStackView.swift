//
//  TopNavigationStackView.swift
//  Vinder
//
//  Created by Victor Chang on 26/12/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

    let settingButton = UIButton(type: .system)
    let messageButton = UIButton(type: .system)
    let fireImageView = UIImageView(image: #imageLiteral(resourceName: "tinder_logo"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 78).isActive = true
        fireImageView.contentMode = .scaleAspectFit

        settingButton.setImage(#imageLiteral(resourceName: "tinder_profile").withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(#imageLiteral(resourceName: "tinder_message").withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingButton, UIView(), fireImageView, UIView(), messageButton].forEach { (view) in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering

        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 18, bottom: 0, right: 18)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
