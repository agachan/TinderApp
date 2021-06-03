//
//  ProfileViewController.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/06/03.
//

import UIKit
import FirebaseAuth
import PKHUD
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    private let cellId = "cellId"
    private let disposeBag = DisposeBag()
    var user: User?
    
    //MARK:UIViews
    let saveButton = UIButton(type: .system).createProfileTopButton(title: "保存")
    let logoutButton = UIButton(type: .system).createProfileTopButton(title: "ログアウト")
    let profileImageView = ProfileImageView()
    let nameLabel = ProfileLabel()
    let profileEditButton = UIButton(type: .system).createProfileEditButton()
    
    lazy var infoCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupLayout()
    }

    private func setupLayout(){
        
        //MARK:Place
        view.backgroundColor = .white
        nameLabel.text = "TestUser"
        view.addSubview(saveButton)
        view.addSubview(logoutButton)
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(profileEditButton)
        view.addSubview(infoCollectionView)
        saveButton.anchor(top: view.topAnchor, left: view.leftAnchor, topPadding: 20,leftPadding: 15)
        logoutButton.anchor(top: view.topAnchor, right: view.rightAnchor, topPadding: 20,rightPadding: 15)
        profileImageView.anchor(top:view.topAnchor,centerX: view.centerXAnchor, width: 180,height: 180,topPadding: 60)
        nameLabel.anchor(top:profileImageView.bottomAnchor,centerX: view.centerXAnchor, topPadding: 20)
        profileEditButton.anchor(top:profileImageView.topAnchor,right: profileImageView.rightAnchor,width: 60,height: 60)
        infoCollectionView.anchor(top:nameLabel.bottomAnchor,bottom: view.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor,topPadding: 20)
        
        //MARK:Info
        nameLabel.text = user?.name
        
    }
    
    private func setupBindings(){
        logoutButton.rx.tap
            .asDriver()
            .drive{[weak self] _ in
                HUD.show(.progress)
                Auth.tappedLogoutButton{(success) in
                    HUD.hide()
                    if success {
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                             let registerController = RegisterViewController()
                             let nav = UINavigationController(rootViewController: registerController)
                             nav.modalPresentationStyle = .fullScreen
                            self?.present(nav, animated: true)
                        }
                    }else{
                    let alert = UIAlertController(title: "エラー",
                                message: "ログアウトできませんでした",
                                preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self?.present(alert, animated: true, completion: nil)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}




//MARK:UICollectionView-Delegate,DataSource
extension ProfileViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        cell.user = self.user
        return cell
    }
    
    
}



