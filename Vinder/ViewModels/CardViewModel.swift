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

struct CardViewModel {
    
    // define the properties that the view will diplay/render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
}


