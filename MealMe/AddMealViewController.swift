//
//  AddMealViewController.swift
//  MealMe
//
//  Created by Monica Ravichandran on 5/28/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit
import Firebase

class AddMealViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var servingTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var keywordsTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    var addedMeal:Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = "Cancel"
    self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        //self.navigationItem.setHidesBackButton(true, animated: true)
        //self.navigationItem.backBarButtonItem
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func mealNameEntered(_ sender: Any) {
    }
    
    @IBOutlet weak var ingredientsEntered: UITextView!
    
    @IBAction func timeEntered(_ sender: Any) {
    }
    @IBAction func servingsEntered(_ sender: Any) {
    }
    @IBAction func priceEntered(_ sender: Any) {
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        print(nameTextField.text!)
        print(descriptionTextView.text!)
        print(timeTextField.text!)
        print(servingTextField.text!)
        print(priceTextField.text!)
        print(keywordsTextView.text!)
        if(nameTextField.text?.isEmpty ?? false || descriptionTextView.text?.isEmpty ?? false || timeTextField.text?.isEmpty ?? false || servingTextField.text?.isEmpty ?? false || priceTextField.text?.isEmpty ?? false || keywordsTextView.text?.isEmpty ?? false){
            
            let alert = UIAlertController(title: "Invalid Input", message: "One or more fields are empty.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else{
            //string.components(separatedBy: "|")
            let ingredientsList = ingredientsEntered.text?.components(separatedBy: ",")
            let id = UUID().uuidString
            let userTableHandler = UserTableHandler()
            userTableHandler.getUser(key: Auth.auth().currentUser?.uid ?? "") { (user) in
                self.addedMeal = Meal(mealId: id, name: self.nameTextField.text ?? "", chefId: Auth.auth().currentUser?.uid ?? "", zipcode: user.zip as? String ?? "", description: self.descriptionTextView.text ?? "", ingredients: ingredientsList ?? [] , time: self.timeTextField.text ?? "", servingSize: self.servingTextField.text as? Int ?? 0, price: self.priceTextField.text as? Float ?? 0.0, keywords: self.keywordsTextView.text ?? "", active: true)
                let mealHandler = MealTableHandler()
                mealHandler.addMeal(meal: self.addedMeal!)
                userTableHandler.addMealToChef(chef: user, chefid: Auth.auth().currentUser?.uid ?? "", mealid: self.addedMeal!.mealId)
                print("segueing")
                self.performSegue(withIdentifier: "backToChefView", sender: self)
            }
            
                
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
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backToChefView"){
            print("INSIDE")
            let chefVC = segue.destination as? ChefTableViewController
            chefVC?.meals.append(self.addedMeal!)
        }
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 
 */

}
