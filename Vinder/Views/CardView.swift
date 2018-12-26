//
//  CardView.swift
//  Vinder
//
//  Created by Victor Chang on 26/12/2018.
//  Copyright © 2018 Victor Chang. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "bike1"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        let panGestrue = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGestrue)
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded()
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { (_) in
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
