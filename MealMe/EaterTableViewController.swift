//
//  EaterTableViewController.swift
//  MealMe
//
//  Created by Aniketh on 5/9/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class EaterTableViewController: BaseViewController, UISearchResultsUpdating{

   
    
    var food = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    var meals = [Meal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for meals"
        navigationItem.searchController = searchController
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Meals", style: .plain, target: nil, action: nil)
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MealTableViewCell")
        //meals = [
        //    Meal(name:"Pizza", chef:"Aniketh", avgRating: 4.4),
        //    Meal(name:"Acapulco", chef:"Anand", avgRating: 5.0),
        //    Meal(name:"Tofu", chef:"Monica", avgRating: 4.7),
        //    Meal(name:"Trash", chef:"Kalyan", avgRating:0.3)
        //]
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 150
        let handler = MealTableHandler()
        let meal = Meal(name:"Pizza", chefEmail: "anandrajiv@gmail.com", avgRating: 4.3)
        self.meals.append(meal)
        handler.getMeals() { (tempMeal) in
            self.meals += tempMeal
            self.tableView.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as?  MealTableViewCell else {
            fatalError("Could not cast")
        }
        
        let meal = meals[indexPath.row]
        cell.mealName.text = meal.name
        cell.chefName.text = meal.chefEmail
        cell.rating.text = String(meal.avgRating)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedMeal = meals[indexPath.row]
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailsSegue" {
            let path = self.tableView.indexPathForSelectedRow
            let selectedMeal = meals[path!.row]
            let detailsVC = segue.destination as? MealDetailsViewController
            detailsVC?.meal = selectedMeal
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
