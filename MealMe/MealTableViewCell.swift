//
//  MealTableViewCell.swift
//  MealMe
//
//  Created by Aniketh on 5/9/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit




class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
