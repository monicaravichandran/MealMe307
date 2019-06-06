//
//  ReviewDetailsViewController.swift
//  MealMe
//
//  Created by Aniketh on 6/5/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit

class ReviewDetailsViewController: UIViewController{

    var review: Review?
    
    
    @IBOutlet weak var eaterName: UILabel!
    
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var rating: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        eaterName.text = review?.eaterName
        rating.text = String(format: "%.2f",(review?.rating)!)
        reviewText.text = review?.text
        eaterName.sizeToFit()
        rating.sizeToFit()
        reviewText.numberOfLines = 10
        reviewText.sizeToFit()
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
