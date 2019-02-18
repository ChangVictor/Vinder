//
//  AgeRangeCell.swift
//  Vinder
//
//  Created by Victor Chang on 18/02/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class AgeRangeCell: UITableViewCell {
    
    let minSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    let maxSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    let minLabel: UILabel = {
        let label = UILabel()
        label.text = "Min 88"
        return label
    }()
    
    let maxLabel: UILabel = {
        let label = UILabel()
        label.text = "Max 88"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let overallStackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [minLabel, minSlider]),
            UIStackView(arrangedSubviews: [maxLabel, maxSlider])
        ])
        overallStackView.axis = .vertical
        addSubview(overallStackView)
        overallStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
