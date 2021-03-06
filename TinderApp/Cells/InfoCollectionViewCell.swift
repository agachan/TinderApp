//
//  InfoCollectionViewCell.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/06/03.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    var user: User?{
        didSet {
            nameTextField.text = user?.name
            emailTextField.text = user?.email
        }
    }
    
    let nameLabel = ProfileLabel(title: "名前")
    let ageLabel = ProfileLabel(title: "年齢")
    let emailLabel = ProfileLabel(title: "Email")
    let regidenseLabel = ProfileLabel(title: "居住地")
    let hobbyLabel = ProfileLabel(title: "趣味")
    let intoroductionLabel = ProfileLabel(title: "自己紹介")
    let nameTextField = ProfileTextField(placeholder: "名前")
    let ageTextField = ProfileTextField(placeholder: "年齢")
    let emailTextField = ProfileTextField(placeholder: "Email")
    let residenceTextField = ProfileTextField(placeholder: "居住地")
    let hobbyTextField = ProfileTextField(placeholder: "趣味")
    let introductionTextField = ProfileTextField(placeholder: "自己紹介")
    
    override init(frame:CGRect) {
        super.init(frame: .zero)
        let views = [[nameLabel,nameTextField], [ageLabel,ageTextField], [emailLabel,emailTextField], [regidenseLabel, residenceTextField], [hobbyLabel, hobbyTextField], [intoroductionLabel, introductionTextField]]
        
        let stackViews = views.map{(views) -> UIStackView in
            guard let label = views.first as? UILabel,
                  let textField = views.last as? UITextField else {return UIStackView()}
            let stackView = UIStackView(arrangedSubviews: [label, textField])
            stackView.axis = .vertical
            stackView.spacing = 5
            textField.anchor(height: 50)
            return stackView
        }
        
        let baseStackView = UIStackView(arrangedSubviews: stackViews)
        baseStackView.axis = .vertical
        baseStackView.spacing = 15
        nameTextField.anchor(width: UIScreen.main.bounds.width - 40, height:80)
        addSubview(baseStackView)
        baseStackView.anchor(top:topAnchor,bottom: bottomAnchor,left: leftAnchor,right: rightAnchor,topPadding: 10,leftPadding: 20,rightPadding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
