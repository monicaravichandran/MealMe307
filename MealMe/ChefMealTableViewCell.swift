//
//  ChefMealTableViewCell.swift
//  MealMe
//
//  Created by Monica Ravichandran on 5/28/19.
import UIKit


protocol deleteCellUpdater: class{
    func updateTableView(mealId:String)
}

class ChefMealTableViewCell: UITableViewCell {
    
    weak var delegate: deleteCellUpdater?
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var activeSwitch: UISwitch!
    
    var mealId : String?
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deleteClicked(_ sender: UIButton) {
        self.delegate?.updateTableView(mealId:self.mealId!)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func toggleActiveMeal(_ sender: UISwitch) {
        let handler = MealTableHandler()
        handler.updateMeals(mealID: mealId!, activeStatus: activeSwitch.isOn)
        
    }
    
}

