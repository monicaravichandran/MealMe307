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
        meals.child(UUID().uuidString).setValue(["name": meal.name, "chefId": meal.chefId, "rating": meal.avgRating])
    }
    
    func getMeals(completion: @escaping ([Meal]) -> Void) {
        var meals = [Meal]()
        ref.child("meals").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let dict = snapshot.value as? [String:Any?] {
                for item in dict {
                    if let val = item.value as? NSDictionary {
                        let meal = Meal(name: val["name"] as? String ?? "", chefId: val["chefId"] as? String ?? "", avgRating: val["rating"] as? Float ?? 0.0)
                        meals.append(meal)
                    }
                
                }
            }
            
            completion(meals)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
}
