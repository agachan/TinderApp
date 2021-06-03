//
//  ProfileTextField.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/06/03.
//

import UIKit

class ProfileTextField: UITextField {

    init(placeholder:String){
        super.init(frame: .zero)
        self.borderStyle = .roundedRect
        self.placeholder = placeholder
        self.backgroundColor = .rgb(r: 245, g: 245, b: 245)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
