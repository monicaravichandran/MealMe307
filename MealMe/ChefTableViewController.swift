//
//  ChefTableViewController.swift
//  MealMe
//
//  Created by Aniketh on 5/28/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit
import Firebase

class ChefTableViewController: BaseViewController, SlideMenuDelegate2 {
    let mealHandler = MealTableHandler()
    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 150
        // Do any additional setup after loading the view.
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        )
        self.navigationItem.title = "Chef Dashboard"
        mealHandler.getMeals(chefId: (Auth.auth().currentUser?.uid as? String)!, completion: { (mealsArr) in
            self.meals = mealsArr
            self.tableView.reloadData()
        })
    
        self.navigationController?.toolbar.items = items
       // let meal = Meal(name:"Pizza", chefEmail: "anandrajiv@gmail.com", avgRating: 4.3)
       // self.meals.append(meal)
    }
    
    override func onSlideMenuButtonPressed(_ sender: UIButton) {
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : ChefHamburgerViewController = self.storyboard!.instantiateViewController(withIdentifier: "ChefHamburgerViewController") as! ChefHamburgerViewController
        menuVC.btnMenu2 = sender
        menuVC.delegate = self as! SlideMenuDelegate2
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChefCell", for: indexPath) as?  ChefMealTableViewCell else {
            fatalError("Could not cast")
        }
        
        let meal = meals[indexPath.row]
        cell.mealId = meal.mealId
        //print(meal.mealId)
        //print(cell.mealId)
        cell.mealName.text = meal.name
        cell.activeSwitch.isOn = meal.active
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedMeal = meals[indexPath.row]
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

