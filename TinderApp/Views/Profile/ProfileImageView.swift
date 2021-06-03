//
//  ProfileImageView.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/06/03.
//

import UIKit

class ProfileImageView: UIImageView{
    
    init() {
        super.init(frame: .zero)
        
        self.image = UIImage(named: "non-profile")
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 90
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
