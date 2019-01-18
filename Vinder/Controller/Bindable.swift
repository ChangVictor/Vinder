//
//  Bindable.swift
//  Vinder
//
//  Created by Victor Chang on 18/01/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
