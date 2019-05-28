//
//  ChefHamburgerViewController.swift
//  MealMe
//
//  Created by Aniketh on 5/28/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

protocol SlideMenuDelegate2 {
    func slideMenuItemSelectedAtIndex(_ index: Int32)
}

class ChefHamburgerViewController: UIViewController {
    
    var btnMenu2: UIButton!
    var delegate: SlideMenuDelegate2?
    let userDefault = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func btnClose(_ sender: UIButton) {
        btnMenu2.tag = 0
        btnMenu2.isHidden = false
        if (self.delegate != nil) {
            var index = Int32(sender.tag)
            if(sender == self.closeButton) {
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width:
                UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    @IBAction func switchToEater(_ sender: Any) {
        performSegue(withIdentifier: "switchToEater", sender: self)
    }
    
    @IBAction func signOut(_ sender: Any) {
        performSegue(withIdentifier: "unwindToSignIn", sender: self)
        do {
            try Auth.auth().signOut()
            try GIDSignIn.sharedInstance()?.signOut()
            userDefault.removeObject(forKey: "usersignedin")
            userDefault.synchronize()
            //self.window?.rootViewController?.performSegue(withIdentifier: "SignOutSegue", sender: nil)
        } catch let error as NSError{
            print("error caught")
            print(error.localizedDescription)
            
        }
    }

}
