//
//  CardInfoLabel.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/02/16.
//

import UIKit

class CardInfoLabel: UILabel {
    init(text: String, textColor: UIColor) {
        super.init(frame: .zero)
        font = .systemFont(ofSize: 45)
        self.text = text
        self.textColor = textColor
        layer.borderWidth = 3
        layer.borderColor = textColor.cgColor
        layer.cornerRadius = 10
        textAlignment = .center
        alpha = 0
        
    }
    
    init(text: String, font: UIFont) {
        super.init(frame: .zero)
        self.font = font
        textColor = .white
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
