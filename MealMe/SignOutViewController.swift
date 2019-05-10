//
//  SignOutViewController.swift
//  MealMe
//
//  Created by Kalyan Vejalla on 5/8/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignOutViewController: UIViewController {
    
    var window: UIWindow?
    let userDefault = UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func signOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            try GIDSignIn.sharedInstance()?.signOut()
            userDefault.removeObject(forKey: "usersignedin")
            userDefault.synchronize()
            
            self.dismiss(animated: true, completion: nil)
            //self.window?.rootViewController?.performSegue(withIdentifier: "SignOutSegue", sender: nil)
            print("SIGNOUT")
        } catch let error as NSError{
            print("error caught")
            print(error.localizedDescription)
            
        }
    }
    
}
