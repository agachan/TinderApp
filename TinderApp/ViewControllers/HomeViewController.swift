//
//  HomeViewController.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/02/13.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PKHUD
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    private var user: User?
    private var users = [User]()
    private let disposeBag = DisposeBag()
    
    let topControlView = TopControlView()
    let cardView = UIView()
    let buttomButton = ButtomControlView()
    
    let logoutButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupBidngs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.fetchUserFromFirestore(uid: uid){(user) in
            if let user = user{
                self.user = user
            }
        }
        fetchUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser?.uid == nil{
                let registerController = RegisterViewController()
                let nav = UINavigationController(rootViewController: registerController)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true)
        }
    }
    
    //MARK:Methods
    private func fetchUsers(){
        HUD.show(.progress)
        Firestore.fetchUsersFromFirestore{(users) in
            HUD.hide()
            
            self.users = users
            print("You get users info except you")
            self.users.forEach{(user) in
                let card = CardView(user: user)
                self.cardView.addSubview(card)
                card.anchor(top:self.cardView.topAnchor,bottom: self.cardView.bottomAnchor,left:self.cardView.leftAnchor,right: self.cardView.rightAnchor)
            }
        }
    }
    
    private func setupLayout(){
        
        
        let stackView = UIStackView(arrangedSubviews: [topControlView,cardView,buttomButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        self.view.addSubview(stackView)
        self.view.addSubview(logoutButton)
        
        [
            topControlView.heightAnchor.constraint(equalToConstant: 100),
            buttomButton.heightAnchor.constraint(equalToConstant: 120),
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)]
            .forEach {$0.isActive = true}
        
        logoutButton.anchor(bottom: view.bottomAnchor,left: view.leftAnchor,bottomPadding: 10,leftPadding: 10)
        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
    }

    @objc private func tappedLogoutButton(){
        
        do{
            try Auth.auth().signOut()
                   DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                        let registerController = RegisterViewController()
                        let nav = UINavigationController(rootViewController: registerController)
                        nav.modalPresentationStyle = .fullScreen
                        self.present(nav, animated: true)
                   }
        } catch {
            print("You cannot logout your account",error)
        }
        
    }
    
    private func setupBidngs(){
        
        topControlView.profileButton.rx.tap
            .asDriver()
            .drive{[weak self] _ in
                let profile = ProfileViewController()
                profile.user = self?.user
                self?.present(profile, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
    }
}
