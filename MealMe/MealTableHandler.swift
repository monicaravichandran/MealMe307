//
//  MealTableHandler.swift
//  MealMe
//
//  Created by Aniketh on 5/22/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import Foundation
import Firebase

class MealTableHandler {
    let ref = Database.database().reference()
    
    func addMeal(meal: Meal) {
        let meals = ref.child("meals")
        meals.setValue(["name": meal.name, "chefId": meal.chefEmail, "rating": meal.avgRating])
    }
    func getMeals(completion: @escaping ([Meal]) -> Void) {
        
    }
}
