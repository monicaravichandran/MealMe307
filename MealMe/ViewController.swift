//
//  ViewController.swift
//  MealMe
//
//  Created by Kalyan Vejalla, Aniketh Bhat on 4/7/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    var window: UIWindow?
    let userDefault = UserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
         
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
    @IBAction func unwindToSignIn(segue: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let userTable = UserTableHandler()
        if segue.identifier == "SignInSegue" {
            let tempUser = Auth.auth().currentUser
            //userTable.addUser(user:tempUser!)
            userTable.getUser(key: tempUser!.uid, completion: { (mealMeUser) in
                if(mealMeUser.name == "NilUser"){ // user does not exists and it is his first time logging in
                    userTable.addUser(user:tempUser!)
                }
            })
            
            //userTable.addUser(user:tempUser!)
            //userTable.getUser(key: tempUser!.uid) { (tempUser) in
             //   eaterVC?.currUser = tempUser
            }
        }
    }
    /*
    @IBAction func didTapSignOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            try GIDSignIn.sharedInstance()?.signOut()
            userDefault.removeObject(forKey: "usersignedin")
            userDefault.synchronize()
            self.window?.rootViewController?.performSegue(withIdentifier: "SignOutSegue", sender: nil)
            print("SIGNOUT")
        } catch let error as NSError{
            print(error.localizedDescription)
            
        }
        
    }
 */
    




