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
        meals.child(meal.mealId).setValue(["mealId": meal.mealId, "name": meal.name, "chefId": meal.chefId, "zipcode": meal.zipcode, "ingredients": meal.ingredients, "description": meal.description, "time": meal.time, "servingSize": meal.servingSize, "price": meal.price, "keywords": meal.keywords, "active": meal.active])
    }
    
    func getMeals(completion: @escaping ([Meal]) -> Void) {
        var meals = [Meal]()
        ref.child("meals").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let dict = snapshot.value as? [String:Any?] {
                for item in dict {
                    if let val = item.value as? NSDictionary {
                        if(val["active"] as? Bool == true){
                            let meal = Meal(mealId: val["mealId"] as? String ?? "", name: val["name"] as? String ?? "", chefId: val["chefId"] as? String ?? "",  zipcode: val["zipcode"] as? String ?? "", description: val["description"] as? String ?? "", ingredients: val["ingredients"] as? String ?? "", time: val["time"] as? String ?? "", servingSize: val["servingSize"] as? String ?? "", price: val["price"] as? String ?? "", keywords: val["keywords"] as? String ?? "", active: val["active"] as? Bool ?? false)
                            meals.append(meal)
                        }
                    }
                
                }
            }
            
            completion(meals)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func getMeals(zipcode:String,keyword: String, completion: @escaping ([Meal]) -> Void) {
        var meals = [Meal]()
        
        ref.child("meals").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let dict = snapshot.value as? [String:Any?] {
                for item in dict {
                    if let val = item.value as? NSDictionary {
                        let words = val["keywords"] as! String
                        let name = val["name"] as! String
                        if((val["active"] as? Bool == true && name.lowercased().contains(keyword.lowercased()) || words.contains(keyword.lowercased())) && (val["zipcode"] as? String == zipcode)){
                            let meal = Meal(mealId: val["mealId"] as? String ?? "", name: val["name"] as? String ?? "", chefId: val["chefId"] as? String ?? "",  zipcode: val["zipcode"] as? String ?? "", description: val["description"] as? String ?? "", ingredients: val["ingredients"] as? String ?? "", time: val["time"] as? String ?? "", servingSize: val["servingSize"] as? String ?? "", price: val["price"] as? String ?? "", keywords: val["keywords"] as? String ?? "", active: val["active"] as? Bool ?? false)
                            meals.append(meal)
                        }
                    }
                    
                }
            }
            
            completion(meals)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    
    func getMeals(chefId: String, completion: @escaping ([Meal]) -> Void) {
        var meals = [Meal]()
        ref.child("meals").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let dict = snapshot.value as? [String:Any?] {
                for item in dict {
                    if let val = item.value as? NSDictionary {
                        if(val["chefId"] as? String == chefId){
                            let meal = Meal(mealId: val["mealId"] as? String ?? "", name: val["name"] as? String ?? "", chefId: val["chefId"] as? String ?? "",  zipcode: val["zipcode"] as? String ?? "", description: val["description"] as? String ?? "", ingredients: val["ingredients"] as? String ?? "", time: val["time"] as? String ?? "", servingSize: val["servingSize"] as? String ?? "", price: val["price"] as? String ?? "", keywords: val["keywords"] as? String ?? "", active: val["active"] as? Bool ?? false)
                            meals.append(meal)
                        }
                    }
                    
                }
            }
            
            completion(meals)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func updateMeals(mealID:String,activeStatus:Bool){
        let meals = ref.child("meals")
        meals.child(mealID).updateChildValues(["active" : activeStatus])
    }
    
    func deleteMeals(mealID:String) {
        let meals = ref.child("meals")
        
        meals.child(mealID).removeValue()
    }
}
