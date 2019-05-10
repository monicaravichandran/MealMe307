//
//  EaterViewController.swift
//  MealMe
//
//  Created by Aniketh on 5/8/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit

class EaterViewController: UIViewController, UISearchResultsUpdating{
    @IBOutlet weak var FoodTable: UITableView!

    var searchController: UISearchController!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController : nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapToHideKeyboard(_ sender: UITapGestureRecognizer) {
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
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
