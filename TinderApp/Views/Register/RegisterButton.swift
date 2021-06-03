//
//  RegisterButton.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/04/05.
//

import UIKit

class RegisterButton: UIButton{
    override var isHighlighted: Bool{
        didSet{
            self.backgroundColor = isHighlighted ? .rgb(r: 227, g: 48, b: 78, alpha: 20) : .rgb(r: 227, g: 48, b: 78)
            
        }
    }
    
    init(text:String){
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        backgroundColor = .rgb(r: 227, g: 48, b: 78)
        layer.cornerRadius = 20
        setTitleColor(.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
