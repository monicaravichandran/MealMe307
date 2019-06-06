//
//  EditAccountViewController.swift
//  MealMe
//
//  Created by Aniketh on 5/29/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit
import Firebase

class EditAccountViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!
    
    
    @IBOutlet weak var zipcodeField: UITextField!
    
    let userHandler = UserTableHandler()
    var currId:String! = nil
    var currUser:MealMeUser! = nil
    var tempUser:User!
    override func viewDidLoad() {
        super.viewDidLoad()
        tempUser = Auth.auth().currentUser!
        currId = tempUser.uid
        userHandler.getUser(key: currId) { (getUser) in
            self.nameField.text = getUser.name
            self.phoneField.text = getUser.phone
            self.zipcodeField.text = String(getUser.zip)
        }
        // Do any additional setup after loading the view.
    }
    
    func goBackTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
    }
    
    @IBAction func updateInfo(_ sender: UIButton) {
        currId = self.tempUser.uid
        userHandler.getUser(key: currId, completion: { (mealmeUser) in
        var updatedUser =
            MealMeUser(name: self.nameField.text!, userEmail: self.tempUser.email!, zip: self.zipcodeField.text! as? String ?? "", phone: self.phoneField.text!, meals: mealmeUser.meals, reviews: mealmeUser.reviews, totalRating: mealmeUser.totalRating, numReviews: mealmeUser.numReviews)
        
            self.userHandler.updateUser(user: updatedUser, userid: self.currId)
        
        })
        goBackTwo()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
