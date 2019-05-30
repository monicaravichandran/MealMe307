//
//  Meal.swift
//  MealMe
//
//  Created by Aniketh on 5/9/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import Foundation
import UIKit

struct Meal {
    let mealId: String
    let name: String
    let chefId: String
    // let image: UIImage
    let description: String
    let ingredients: [String]
    let time: String
    let servingSize: Int
    let price: Float
    let keywords: String
    let active: Bool
}

