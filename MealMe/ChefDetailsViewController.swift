//
//  ChefDetailsViewController.swift
//  MealMe
//
//  Created by Aniketh on 5/28/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit

class ChefDetailsViewController: UIViewController {
    var chefId:String?
    var chef: MealMeUser?
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var chefEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userHandler = UserTableHandler()
        userHandler.getUser(key: chefId!) { (tempUser) in
            self.chefName.text = tempUser.name
            self.chefEmail.text = tempUser.userEmail
        }
        
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

}
