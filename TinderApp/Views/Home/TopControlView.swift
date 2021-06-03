//
//  TopControlView.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/02/13.
//

import UIKit
import RxCocoa
import RxSwift

class TopControlView: UIView {
    private let disposeBag = DisposeBag()
    
//    ボタンのImageをセットする
    let tinderButton = createTopButton(selectedImageName: "tinder", unselectedImageName: "non-tinder")
    let goodButton = createTopButton(selectedImageName: "diamond", unselectedImageName: "non-diamond")
    let commentButton = createTopButton(selectedImageName: "comment", unselectedImageName: "non-comment")
    let profileButton = createTopButton(selectedImageName: "profile", unselectedImageName: "non-profile")
    
//    ボタンの方を決めるメソッド
    static private func createTopButton(selectedImageName:String , unselectedImageName:String) -> UIButton{
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: selectedImageName), for: .selected)
        button.setImage(UIImage(named: unselectedImageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupBindings()
    }
    
    private func setupLayout(){
        let baseStackView = UIStackView(arrangedSubviews: [tinderButton,goodButton,commentButton,profileButton])
        baseStackView.axis = .horizontal
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 43
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(baseStackView)
        
        baseStackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, leftPadding: 40, rightPadding: 40)
        
        tinderButton.isSelected = true
    }
    
    private func setupBindings(){
        tinderButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.tinderButton)
            })
            .disposed(by: disposeBag)
        
        goodButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.goodButton)
            })
            .disposed(by: disposeBag)
        
        commentButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.commentButton)
            })
            .disposed(by: disposeBag)
        
        profileButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.handleSelectedButton(selectedButton: self.profileButton)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleSelectedButton(selectedButton: UIButton){
        let buttons = [tinderButton, goodButton, commentButton, profileButton]
        buttons.forEach { button in
            if button == selectedButton{
                button.isSelected = true
            }else{
                button.isSelected = false
            }
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
