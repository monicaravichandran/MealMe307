//
//  AddMealViewController.swift
//  MealMe
//
//  Created by Monica Ravichandran on 5/28/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit

class AddMealViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nameEntered(_ sender: UITextField) {
        print(nameTextField.text!)
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        print(nameTextField.text!)
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
