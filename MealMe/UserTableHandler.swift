//
//  UserTableHandler.swift
//  MealMe
//
//  Created by Kalyan Vejalla on 5/28/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

//

import Foundation
import GoogleSignIn
import Firebase

class UserTableHandler {
    let ref = Database.database().reference()
    
    func addUser(user: User)
    {
        let users = ref.child("users")
        users.child(user.uid).setValue(["name": user.displayName, "email": user.email, "phone": "N/A", "zip": 94086, "meals": [Meal](),"reviews": [Review]()])
    }

    
    func updateUser(user: MealMeUser, userid: String)
    {
        let users = ref.child("users")
        
        users.child(userid).setValue(["name": user.name, "email": user.userEmail, "phone": user.phone, "zip": user.zip, "meals": user.meals,
                                      "reviews":user.reviews])
    }
    
    func getUser(key : String, completion: @escaping (MealMeUser) -> Void) {
        var mealMeUser : MealMeUser?
        var exists = 0
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let dict = snapshot.value as? [String:Any?] {
                for item in dict {
                    if item.key == key {
                        exists = 1
                        if let val = item.value as? NSDictionary{
                            let curUser = MealMeUser(name: val["name"] as? String ?? "", userEmail: val["chefId"] as? String ?? "", zip: val["zip"] as? String ?? "", phone: val["phone"] as? String ?? "", meals: val["meals"] as?  [String] ?? [], reviews: val["reviews"] as? [String] ?? [])

                            mealMeUser = curUser
                        }
                    }
                    
                    
                    /*if let val = item.value as? NSDictionary {
                        let meal = MealMeUser(name: val["name"] as? String ?? "", chefEmail: val["chefId"] as? String ?? "", avgRating: val["rating"] as? Float ?? 0.0)
                        meals.append(meal)*/
                }
                if(exists == 1){
                    DispatchQueue.main.async {
                        completion(mealMeUser!)
                    }
                }
                else{
                    let nilUser = MealMeUser(name: "NilUser", userEmail: "NIL", zip: "", phone: "NIL", meals: [], reviews: [])

                    completion(nilUser)
                }
            }
            
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

    func addMealToChef(chef: MealMeUser, chefid: String, mealid: String)
    {
        var currMeals : [String]
        currMeals =  chef.meals
        currMeals.append(mealid)
        let updatedUser = MealMeUser(name: chef.name, userEmail: chef.userEmail, zip: chef.zip, phone: chef.phone, meals: currMeals, reviews: chef.reviews)
        self.updateUser(user: updatedUser, userid: chefid)
    }

    
    func addReviewToChef(chefid: String, reviewID: String)
    {
        self.getUser(key: chefid, completion: { (chef) in
            
            var currReviews : [String]
            currReviews =  chef.reviews
            currReviews.append(reviewID)
            let updatedUser = MealMeUser(name: chef.name, userEmail: chef.userEmail, zip: chef.zip, phone: chef.phone, meals: chef.meals, reviews: currReviews)
            self.updateUser(user: updatedUser, userid: chefid)
        })
        
        
        }
    

    
}
