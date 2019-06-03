//
//  Review.swift
//  MealMe
//
//  Created by Kalyan Vejalla on 5/31/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import Foundation
import UIKit

struct Review {
    let reviewId: String
    let rating: Double
    let text: String
    let eaterName: String // eater is author of review 
    let eaterId: String
    let chefId: String // chef is who the review is for
}
