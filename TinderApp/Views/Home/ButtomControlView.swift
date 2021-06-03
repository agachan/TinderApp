//
//  ButtomControlView.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/02/13.
//

import UIKit

class ButtomControlView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let reloadButton = ButtomButtonView(frame: .zero, width: 50, imageName: "reload")
        let crossButton = ButtomButtonView(frame: .zero, width: 60, imageName: "cross")
        let starButton = ButtomButtonView(frame: .zero, width: 50, imageName: "star")
        let hartButton = ButtomButtonView(frame: .zero, width: 60, imageName: "hart")
        let thunderButton = ButtomButtonView(frame: .zero, width: 50, imageName: "thunder")
        
        let baseStackView = UIStackView(arrangedSubviews: [reloadButton,crossButton,starButton,hartButton,thunderButton])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 10
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseStackView)
        
        [
            baseStackView.topAnchor.constraint(equalTo: topAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseStackView.leftAnchor.constraint(equalTo: leftAnchor ,constant: 10),
            baseStackView.rightAnchor.constraint(equalTo: rightAnchor,constant: -10),
            
        ].forEach {$0.isActive = true}
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class ButtomButtonView: UIView {
    var button:ButtomButton?
    
    
    init(frame: CGRect, width: CGFloat,imageName:String) {
        super.init(frame: frame)
        
        button = ButtomButton(type: .custom)
        button?.setImage(UIImage(named: imageName)?.resize(size: .init(width: width * 0.4, height: width * 0.4)), for: .normal)
        button?.backgroundColor = .white
        button?.translatesAutoresizingMaskIntoConstraints = false
        button?.layer.cornerRadius = width / 2
        button?.layer.shadowOffset = .init(width:1.5,height:2)
        button?.layer.shadowColor = UIColor.black.cgColor
        button?.layer.shadowOpacity = 0.3
        button?.layer.shadowRadius = 15
        addSubview(button!)
        
        button?.anchor(centerY: centerYAnchor, centerX: centerXAnchor, width: width, height: width)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ButtomButton: UIButton {
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []){
                    self.transform = .init(scaleX: 0.8, y:0.8)
                    self.layoutIfNeeded()
                }
            }else{
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: []){
                    self.transform = .identity
                    self.layoutIfNeeded()
                }
            }
        }
    }
}
