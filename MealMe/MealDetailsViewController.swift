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
    @IBOutlet weak var ChefNameButton: UIButton!
    var chef:MealMeUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Meal Details", style: .plain, target: nil, action: nil)
        let userHandler = UserTableHandler()
        
        userHandler.getUser(key: self.meal?.chefId as? String ?? "") { (tempUser) in
            self.ChefNameButton.titleLabel?.text = tempUser.name
        }
        mealName.text = meal?.name
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showChefDetails" {
            let chefDetailsVC = segue.destination as? ChefDetailsViewController
            chefDetailsVC?.chefId = meal?.chefId
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
