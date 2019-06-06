//
//  MealDetailsViewController.swift
//  MealMe
//
//  Created by Aniketh on 5/22/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit

class MealDetailsViewController: UIViewController {
    
    var meal:Meal?
    @IBOutlet weak var mealName: UILabel!
    //@IBOutlet weak var ChefNameButton: UIButton!
    var chef:MealMeUser?
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var servingLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Meal Details", style: .plain, target: nil, action: nil)
        let userHandler = UserTableHandler()
        
        userHandler.getUser(key: self.meal?.chefId as? String ?? "") { (tempUser) in
            print(tempUser.name)
           // self.ChefNameButton.titleLabel?.text = tempUser.name
        }
        mealName.text = meal?.name
        mealName.numberOfLines = 3
        mealName.sizeToFit()
        descriptionLabel.text = meal?.description
        descriptionLabel.numberOfLines = 4
        descriptionLabel.sizeToFit()
        ingredientsLabel.text = meal?.ingredients
        ingredientsLabel.numberOfLines = 4
        ingredientsLabel.sizeToFit()
        timeLabel.text = meal?.time
        servingLabel.text = meal?.servingSize
        priceLabel.text = meal?.price
        
        // Do any additional setup after loading the view.
    }
 
    
    /*func viewDidLoadBack(curChefID: String, curMeal: Meal, completion: @escaping (MealMeUser) -> Void) {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Meal Details", style: .plain, target: nil, action: nil)
        let userHandler = UserTableHandler()
        
        userHandler.getUser(key: curChefID as? String ?? "") { (tempUser) in
            print("HEY HERE")
            print(tempUser.name)
            self.ChefNameButton.titleLabel?.text = tempUser.name
        }

        print("VIEW DID LOAD BACK")
        print(curMeal.name)
        mealName.text = curMeal.name
        
        var mealMeUserHolder : MealMeUser?
        let curUser = MealMeUser(name: "NA", userEmail: "NA", zip: -1, phone: "NA", meals: ["NA"])
        mealMeUserHolder = curUser
        completion(mealMeUserHolder!)
        
        // Do any additional setup after loading the view.
    } */
    
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showChefDetails" {
            let chefDetailsVC = segue.destination as? ChefDetailsViewController
            chefDetailsVC?.chefId = meal?.chefId
            chefDetailsVC?.meal = self.meal
            print("MEAL HERE")
            print(self.meal?.name)
        }
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
