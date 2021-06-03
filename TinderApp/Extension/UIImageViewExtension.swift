//
//  UIImageViewExtension.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/02/16.
//

import UIKit

class CardImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
                backgroundColor = .brown
                layer.cornerRadius = 10
                contentMode = .scaleAspectFill
                image = UIImage(url: "https://sakurazaka46.com/images/14/498/3fa562aaa5d1b38f48656fe919b15/1000_1000_102400.jpg")
                clipsToBounds = true
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
