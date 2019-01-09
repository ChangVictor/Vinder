//
//  CardViewModel.swift
//  Vinder
//
//  Created by Victor Chang on 06/01/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    
    func toCardViewModel() -> CardViewModel
    
}

// ViewModel is supposed to represent the State of our View

class CardViewModel {
    
    // define the properties that the view will diplay/render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageName = imageNames[imageIndex]
            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, image)
        }
    }
    
    // Reactive programming
    var imageIndexObserver: ((Int, UIImage?) -> ())?
    
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}


