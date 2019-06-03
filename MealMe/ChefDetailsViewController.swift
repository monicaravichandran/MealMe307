//
//  ChefDetailsViewController.swift
//  MealMe
//
//  Created by Aniketh on 5/28/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit
import Firebase

class ChefDetailsViewController: UIViewController {
    var chefId:String?
    var chef: MealMeUser?
    var meal:Meal?
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var sliderField: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var chefEmail: UILabel!
    let mealDetailsViewController = MealDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userHandler = UserTableHandler()
        userHandler.getUser(key: chefId!) { (tempUser) in
            self.chefName.text = tempUser.name
            self.chefEmail.text = tempUser.userEmail
        }
        sliderField.text = "0"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func slide(_ sender: UISlider) {
        self.sliderField.text = String(format: "%.2f",self.slider.value)
    }
    
    @IBAction func submitReview(_ sender: Any)
    {
        let userTable = UserTableHandler()
        let reviewTable = ReviewTableHandler()
        let tempUser = Auth.auth().currentUser
        userTable.getUser(key: tempUser!.uid, completion: { (eaterUser) in
            
            var newReview = Review(reviewId: UUID().uuidString, rating: Double(self.slider!.value), text: self.reviewText.text, eaterName: eaterUser.name, eaterId: tempUser!.uid, chefId: self.chefId!)
            
            reviewTable.addReviewToChef(review: newReview)
            userTable.addReviewToChef(chefid: self.chefId!, reviewID: newReview.reviewId)
                    
            })
            
        }

        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*override func viewWillDisappear(_ animated: Bool) {
        // Do Your Lines of Code ...
        //mealDetailsViewController.viewDidLoadBack(curChefID: self.chefId!, curMeal: self.meal!)
        
        
         mealDetailsViewController.viewDidLoadBack(curChefID: self.chefId!, curMeal: self.meal!) { (tempUser) in
         }
    }*/

}
