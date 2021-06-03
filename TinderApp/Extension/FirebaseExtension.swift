//
//  FirebaseExtension.swift
//  TinderApp
//
//  Created by AGA TOMOHIRO on 2021/06/03.
//
import UIKit
import Firebase

extension Auth{
    //MARK:CreateUserOnFirebaseAuth
    static func createUserToFireAuth(email: String?, password: String?, name: String?, completion:@escaping (Bool)->Void){
        guard let email = email else {return}
        guard let password = password else {return}
        
        Auth.auth().createUser(withEmail: email, password: password){(auth, err) in
            if let err = err{
                print("You cannot create New Tinder Account", err)
                return
            }
            print("Create Your Account")
            guard let uid = auth?.user.uid else {return}
            Firestore.setUserDataToFirestore(email:email, uid: uid, name: name){ success in
                completion(success)
            }
        }
    }
    
    static func loginWithFireAuth(email:String, password:String,completion:@escaping (Bool)->Void){
        Auth.auth().signIn(withEmail: email, password: password){(res,err)  in
            if let err = err{
                print("You cannot Login your account",err)
                completion(false)
                return
                
            }
            print("You success & login your account")
            completion(true)
        }
    }
    
    static func tappedLogoutButton(completion: @escaping (Bool)-> Void){
        do{ try Auth.auth().signOut()
            print("Success logout your account")
            completion(true)
        } catch {
            print("You cannot logout your account",error)
            completion(false)
        }
    }
}

extension Firestore{
    //MARK:Create&ConnectFromFirebaseAuthToFirestore
    static func setUserDataToFirestore(email:String, uid: String, name:String?, completion:@escaping (Bool)->()){
        guard let name = name else {return}
        let document = [
            "name": name,
            "email": email,
            "createAt": Timestamp()
        ] as [String: Any]
        
        
        Firestore.firestore().collection("users").document(uid).setData(document){
            err in
            if let err = err{
                print("You cannot save your account in FireStore", err)
                return
            }
            print("Connect To Firestore")
            completion(true)
        }
    }
    
    
    static func fetchUserFromFirestore(uid:String, compeltion:@escaping (User?)->Void){
        Firestore.firestore().collection("users").document(uid).getDocument{(snapshot, err) in
            if let err = err{
                print("You cannot get your account data",err)
                compeltion(nil)
                return
            }
            guard let dic = snapshot?.data() else {return}
            let user = User(dic: dic)
            compeltion(user)
            
            
        }
    }
    
    static func fetchUsersFromFirestore(completion: @escaping([User])->Void){
        Firestore.firestore().collection("users").getDocuments{(snapshot, err) in
            if let err = err{
                print("You cannot get your account data",err)
                return
            }
            let users = snapshot?.documents.map({(snapshot)->User in
                    let dic = snapshot.data()
                    let user = User(dic: dic)
                return user
            })
            completion(users ?? [User]())
        }
    }
}
