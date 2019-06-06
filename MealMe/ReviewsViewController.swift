//
//  ReviewsViewController.swift
//  MealMe
//
//  Created by Aniketh on 6/5/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit

class ReviewsViewController: UITableViewController {
    var chefId:String?
    var reviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Chef Details", style: .plain, target: nil, action: nil)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 250
        self.navigationItem.title = "All Reviews"
        
        let reviewHandler = ReviewTableHandler()
        reviewHandler.getReviewsForChef(chefID: self.chefId!) { (reviews) in
            self.reviews = reviews
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as?  ReviewViewCell else {
            fatalError("Could not cast")
        }
        
        let review = reviews[indexPath.row]
        cell.eaterName.text = "Name:" + review.eaterName
        cell.rating.text = String(format: "Rating: %.2f",review.rating)
        cell.review.text = "Review: " + review.text
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showReviewDetailsSegue" {
            let path = self.tableView.indexPathForSelectedRow
            let selectedReview = reviews[path!.row]
            let detailsVC = segue.destination as? ReviewDetailsViewController
            detailsVC?.review = selectedReview
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

}
