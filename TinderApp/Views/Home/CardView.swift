//
//  CardView.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/02/14.
//

import UIKit

class CardView: UIView {
    
    private let gradationLayer = CAGradientLayer()
    private let cardImageView = CardImageView(frame: .zero)
    private let infoButton = UIButton(type: .system).createCardInfoButton()
    private let nameLabel = CardInfoLabel(text: "上村莉奈 22", font: .systemFont(ofSize: 40, weight: .heavy))
    private let residenceLabel = CardInfoLabel(text: "日本　千葉", font: .systemFont(ofSize: 20, weight: .regular))
    private let hobbyLabel = CardInfoLabel(text: "櫻坂46の妖精です", font: .systemFont(ofSize: 25, weight: .regular))
    private let intoroductionLabel = CardInfoLabel(text: "トランペットはブハブハです", font: .systemFont(ofSize: 25, weight: .regular))
    
    private let goodLabel = CardInfoLabel(text: "GOOD", textColor: UIColor.rgb(r: 137, g: 223, b: 86))
    
    private let nopeLabel: UILabel = CardInfoLabel(text: "NOPE", textColor: UIColor.rgb(r: 222, g: 110, b: 110))
    
    init(user: User) {
        super.init(frame: .zero)
        setupLayout(user: user)
        setupGradationLayer()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCardView))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func panCardView(gesture:UIPanGestureRecognizer){
        let translation = gesture.translation(in: self)
        guard let view = gesture.view else { return }
        
        if gesture.state == .changed{
            handlePanChanged(translation: translation)
        }else if gesture.state == .ended{
            handlePanEnded(view: view, translation: translation)
        }
    }
    private func setupGradationLayer(){
        gradationLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradationLayer.locations = [0.5, 1.1]
        cardImageView.layer.addSublayer(gradationLayer)
    }
    
    override func layoutSubviews() {
        gradationLayer.frame = self.bounds
    }
    
    private func handlePanChanged(translation:CGPoint){
        let degree = translation.x / 20
        let angle = degree * .pi / 100
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
        
        let ration:CGFloat = 1/100
        let rationValue = ration * translation.x
        if translation.x > 0{
            self.goodLabel.alpha = rationValue
        }else if translation.x < 0{
            self.nopeLabel.alpha = -rationValue
        }
    }
    
    private func handlePanEnded(view: UIView,translation:CGPoint){
        
        if translation.x <= -120{
            view.removeCardViewAnimation(x: -600)
        }else if translation.x >= 120{
            view.removeCardViewAnimation(x: 600)
        }else{
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []){
                self.transform = .identity
                self.layoutIfNeeded()
                self.goodLabel.alpha = 0
                self.nopeLabel.alpha = 0
        }
        
        }
    }
    
    private func setupLayout(user: User){
        let infoVarticalStackVIew = UIStackView(arrangedSubviews: [residenceLabel,hobbyLabel,intoroductionLabel])
        infoVarticalStackVIew.axis = .vertical
        
        let baseStackView = UIStackView(arrangedSubviews: [infoVarticalStackVIew,infoButton])
        baseStackView.axis = .horizontal
        
        //Viewの配置を作成
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        addSubview(goodLabel)
        addSubview(nopeLabel)
        
        cardImageView.anchor(top:topAnchor,bottom: bottomAnchor,left: leftAnchor,right: rightAnchor,leftPadding: 10,rightPadding: 10)
        infoButton.anchor(width:40)
        baseStackView.anchor(bottom:cardImageView.bottomAnchor, left: cardImageView.leftAnchor ,bottomPadding:20, leftPadding: 20, rightPadding: 20)
        nameLabel.anchor(bottom:baseStackView.topAnchor, left: cardImageView.leftAnchor ,bottomPadding: 10, leftPadding: 20)
        goodLabel.anchor(top:cardImageView.topAnchor, left: cardImageView.leftAnchor, width: 140 ,height: 55, topPadding: 25, leftPadding: 20)
        nopeLabel.anchor(top:cardImageView.topAnchor, right: cardImageView.rightAnchor , width: 140 ,height: 55, topPadding: 25, rightPadding: 20)
        
        nameLabel.text = user.name
        intoroductionLabel.text = user.email
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
