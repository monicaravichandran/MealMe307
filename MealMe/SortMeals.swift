//
//  SortMeals.swift
//  MealMe
//
//  Created by Kalyan Vejalla on 6/6/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase

import Foundation
import UIKit

struct MealForSort {
    let mealId: String
    let name: String
    let chefId: String
    let zipcode: String
    // let image: UIImage
    let description: String
    let ingredients: String
    let time: String
    let servingSize: String
    let price: String
    let keywords: String
    let active: Bool
    let avgRating: Float
}

class SortMeals
{

    func sortMealsRating(mealsList: [Meal], completion: @escaping ([MealForSort]) -> Void)
    {
        let userTable = UserTableHandler()
        var newMeals = [MealForSort]() //= []
        let group = DispatchGroup()
        for item in mealsList
        {
            group.enter()
            print("IN LOOP")
            userTable.getUser(key: item.chefId, completion: { (mealMeChef) in
                var chefRating = mealMeChef.totalRating / Float(mealMeChef.numReviews)
                var newMeal =  MealForSort(mealId: item.mealId , name: item.name, chefId: item.chefId,  zipcode: item.zipcode, description: item.description, ingredients: item.ingredients, time: item.time, servingSize: item.servingSize, price: item.price, keywords: item.keywords, active: item.active, avgRating: chefRating)
                print("IN COMPLETION")
                newMeals.append(newMeal)
                group.leave()
                }
            
            )
        
        
        }
        
        group.notify(queue: DispatchQueue.main, execute: {() in
            newMeals.sort { $0.avgRating < $1.avgRating}
            completion(newMeals)
            
        })
    
    }
    
    func convertMeals(mealsSort: [MealForSort], completion: @escaping ([Meal]) -> Void)
    {
        var newMeals = [Meal]()
        for item in mealsSort
        {
            var meal =  Meal(mealId: item.mealId , name: item.name, chefId: item.chefId,  zipcode: item.zipcode, description: item.description, ingredients: item.ingredients, time: item.time, servingSize: item.servingSize, price: item.price, keywords: item.keywords, active: item.active)
            newMeals.append(meal)
        }
        completion(newMeals)
        
    }
    
    
    

    
    
}
