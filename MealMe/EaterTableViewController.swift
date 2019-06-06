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

class EaterTableViewController: BaseViewController, UISearchResultsUpdating, UISearchBarDelegate{

   
    
    var food = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    var meals = [Meal]()
    var filteredMeals = [Meal]()
    let mealHandler = MealTableHandler()
    let userHandler = UserTableHandler()
    var currId : String!
    var currUser: MealMeUser!
    var filtered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        let search = Search()
        //search.searchByKeywords(keyword: "hello", completion: //)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        //searchController.obscuresBackgroundDuringPresentation = false
        //searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for meals"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["None", "Price", "Rating"]
        navigationItem.searchController = searchController
        definesPresentationContext = true
        //searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Meals", style: .plain, target: nil, action: nil)
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MealTableViewCell")
        //meals = [
        //    Meal(name:"Pizza", chef:"Aniketh", avgRating: 4.4),
        //    Meal(name:"Acapulco", chef:"Anand", avgRating: 5.0),
        //    Meal(name:"Tofu", chef:"Monica", avgRating: 4.7),
        //    Meal(name:"Trash", chef:"Kalyan", avgRating:0.3)
        //]
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 250
        self.navigationItem.title = "Eater Dashboard"
        let tempUser = Auth.auth().currentUser
        currId = tempUser?.uid
        userHandler.getUser(key: currId) { (getUser) in
            self.currUser = getUser
        }
        
        print(currUser)
        //let meal = Meal(name:"Pizza", chefId: currId, avgRating: 4.3)
        //mealHandler.addMeal(meal: meal)
        //let meal2 = Meal(name: "Acapulco", chefId: currId, avgRating: 5.0)
        //mealHandler.addMeal(meal: meal2)
        mealHandler.getMeals() { (mealsArr) in
            self.meals += mealsArr
            self.tableView.reloadData()
        }
        
       // self.userTable.addUser(currUser: GIDGoogleUser)
        
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
        if isFiltering() {
            return filteredMeals.count
        }
        
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as?  MealTableViewCell else {
            fatalError("Could not cast")
        }
        
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let meal: Meal
        
        if isFiltering() {
            meal = filteredMeals[indexPath.row]
        } else {
            meal = meals[indexPath.row]
        }
        
        cell.mealName.text = meal.name
        userHandler.getUser(key: meal.chefId) { (tempUser) in
            cell.chefName.text = tempUser.name
            if tempUser.numReviews == 0 {
                cell.rating.text = "No rating available"
            } else {
            cell.rating.text = String(format: "%.2f", tempUser.totalRating / Float(tempUser.numReviews))
        
            }
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectedMeal = meals[indexPath.row]
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let search = Search()
        //filterContentForSearchText(searchController.searchBar.text!)
        search.searchByKeywords(keyword: searchController.searchBar.text!) { (newMeals) in
            if(!newMeals.isEmpty){
                self.meals = newMeals
                self.filteredMeals = newMeals
            }
        }
        
        print("tb",filteredMeals)
        tableView.reloadData()
    }
    /*func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let search = Search()
        filterContentForSearchText(searchBar.text!)
        search.searchByKeywords(keyword: searchBar.text!) { (newMeals) in
            if(!newMeals.isEmpty){
                self.meals = newMeals
                self.filteredMeals = newMeals
            }
        }
        
        print("tb",filteredMeals)
        tableView.reloadData()
        
    }*/
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMeals = meals.filter({( meal : Meal) -> Bool in
            return meal.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //var newMeals = meals
        let selectedMeal:Meal
        let path = self.tableView.indexPathForSelectedRow
        //if(!filteredMeals.isEmpty){
          //  print("filtering")
           // selectedMeal = filteredMeals[path!.row]
            //print(newMeals)
        //}
        //else{
           // selectedMeal = meals[path!.row]
        //}
        if isFiltering() {
            selectedMeal = filteredMeals[path!.row]
        } else {
            selectedMeal = meals[path!.row]
        }
        if segue.identifier == "detailsSegue" {
            let detailsVC = segue.destination as? MealDetailsViewController
            detailsVC?.meal = selectedMeal
            detailsVC?.navigationItem.leftItemsSupplementBackButton = true
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if(searchBar.scopeButtonTitles![selectedScope] == "Rating"){
            let sortMeals = SortMeals()
            sortMeals.sortMealsRating(mealsList: self.meals, completion: { (newSortedMeals) in
                print("THIS")
                print(newSortedMeals)
                sortMeals.convertMeals(mealsSort: newSortedMeals, completion: { (newSortedMeals) in
                    self.meals = newSortedMeals
                    self.tableView.reloadData()
                })
            })
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
