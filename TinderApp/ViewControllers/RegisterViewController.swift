//
//  RegisterViewController.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/04/04.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class RegisterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = RegisterViewModel()
    //MARK: UIViews
    private let titleLabel = RegisterTitleLabel(text: "Tinder")
    private let nameTextField = RegisterTextField(placeHolder: "Name")
    private let emailTextField = RegisterTextField(placeHolder: "Email")
    private let passwordTextField = RegisterTextField(placeHolder: "Password")
    private let registerButton = RegisterButton(text: "登録")
    private let alreadyHaveAccountButton = UIButton(type: .system).createAboutAccountButton(text: "既にアカウントをお持ちの方はこちら")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: Methods
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
        
        
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField,emailTextField, passwordTextField, registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        nameTextField.anchor(height: 45)
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(alreadyHaveAccountButton)
        baseStackView.anchor(left: view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftPadding: 20, rightPadding: 20)
        titleLabel.anchor(bottom: baseStackView.topAnchor, centerX: view.centerXAnchor, bottomPadding: 20)
        alreadyHaveAccountButton.anchor(top: baseStackView.bottomAnchor, centerX: view.centerXAnchor, topPadding: 20)
    }
    
    private func setupBindings(){
        nameTextField.rx.text
            .asDriver()
            .drive{ [weak self] text in
                self?.viewModel.nameTextInput.onNext(text ?? "")
            }
            .disposed(by: disposeBag)
        emailTextField.rx.text
            .asDriver()
            .drive{ [weak self] text in
                
            }
            .disposed(by: disposeBag)
        passwordTextField.rx.text
            .asDriver()
            .drive{ [weak self] text in
                
            }
            .disposed(by: disposeBag)
        registerButton.rx.tap
            .asDriver()
            .drive{[weak self] _ in
                self?.createUser()
            }
            .disposed(by: disposeBag)
        
        alreadyHaveAccountButton.rx.tap
            .asDriver()
            .drive{[weak self] _ in
                let login = LoginViewController()
                self?.navigationController?.pushViewController(login, animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.validRegisterDriver
            .drive{validAll in
                self.registerButton.isEnabled = validAll
                self.registerButton.backgroundColor = validAll ? .rgb(r: 227, g: 48, b: 78):
                    .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBag)
    }
    private func createUser(){
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        
        HUD.show(.progress)
        Auth.createUserToFireAuth(email: email, password: password, name: name){success in
            if success{
                print("Completed")
                HUD.hide()
                self.dismiss(animated: true)
            }else{
                print("Error")
            }
        }
    }
    

}
