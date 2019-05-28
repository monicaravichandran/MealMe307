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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Meal Details", style: .plain, target: nil, action: nil)
        mealName.text = meal?.name
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
