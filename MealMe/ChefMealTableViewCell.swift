//
//  ChefMealTableViewCell.swift
//  MealMe
//
//  Created by Monica Ravichandran on 5/28/19.
import UIKit




class ChefMealTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    
    var mealId : String?
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func toggleActiveMeal(_ sender: UISwitch) {
        let handler = MealTableHandler()
        handler.updateMeals(mealID: mealId!, activeStatus: activeSwitch.isOn)
        
    }
    
}

