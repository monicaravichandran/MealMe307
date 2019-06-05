//
//  ReviewViewCell.swift
//  MealMe
//
//  Created by Aniketh on 6/5/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import UIKit

class ReviewViewCell: UITableViewCell {

    @IBOutlet weak var eaterName: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var review: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
