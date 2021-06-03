//
//  LoginViewController.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/06/03.
//

import UIKit
import RxSwift
import FirebaseAuth
import PKHUD

class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    //MARK: UIViews
    private let titleLabel = RegisterTitleLabel(text:"LOGIN")
    private let nameTextField = RegisterTextField(placeHolder: "Name")
    private let emailTextField = RegisterTextField(placeHolder: "Email")
    private let passwordTextField = RegisterTextField(placeHolder: "Password")
    private let loginButton = RegisterButton(text: "ログイン")
    private let donotHaveAccountButton = UIButton(type: .system).createAboutAccountButton(text: "アカウントをお持ちでない方はこちら")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
        setupGradientLayer()
        setupLayout()
    }
    
    private func setupGradientLayer(){
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(r: 277, g: 48, b: 78).cgColor
        let endColor = UIColor.rgb(r: 245, g: 208, b: 108).cgColor
        
        layer.colors = [startColor, endColor]
        layer.locations = [0.0, 1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        
    }
    
    private func setupLayout(){
        passwordTextField.isSecureTextEntry = true
        emailTextField.textContentType = .emailAddress
        emailTextField.keyboardType = .emailAddress
        
        
        let baseStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        emailTextField.anchor(height: 45)
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(donotHaveAccountButton)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 20, rightPadding: 20)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        donotHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
    }
    
    private func setupBindings(){
        donotHaveAccountButton.rx.tap
            .asDriver()
            .drive{[weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .asDriver()
            .drive{[weak self] _ in
                self?.login()
            }
            .disposed(by: disposeBag)
        
    }
    
    private func login(){
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        HUD.show(.progress)
        Auth.loginWithFireAuth(email: email, password: password){(success) in
            HUD.hide()
            if success {
                self.dismiss(animated: true, completion: nil)
            }else{
                
            }
        }
    }
    

}
