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
        users.child(user.uid).setValue(["name": user.displayName, "email": user.email, "phone": "N/A", "zip": "94086", "meals": [Meal](),"reviews": [Review](), "totalRating": 0.0, "numReviews":0])
    }
    
    func updateUser(user: MealMeUser, userid: String)
    {
        let users = ref.child("users")
        
        users.child(userid).setValue(["name": user.name, "email": user.userEmail, "phone": user.phone, "zip": user.zip, "meals": user.meals,
                                      "reviews":user.reviews, "totalRating":user.totalRating, "numReviews":user.numReviews])
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
                            let curUser = MealMeUser(name: val["name"] as? String ?? "", userEmail: val["email"] as? String ?? "", zip: val["zip"] as? String ?? "", phone: val["phone"] as? String ?? "", meals: val["meals"] as?  [String] ?? [], reviews: val["reviews"] as?  [String] ?? [], totalRating: val["totalRating"] as? Float ?? 0.0, numReviews: val["numReviews"] as? Int ?? 0)
                            mealMeUser = curUser
                        }
                    }
                    
                    
                    /*if let val = item.value as? NSDictionary {
                        let meal = MealMeUser(name: val["name"] as? String ?? "", chefEmail: val["chefId"] as? String ?? "", avgRating: val["rating"] as? Float ?? 0.0)
                        meals.append(meal)*/
                }
            }
            if(exists == 1){
                // DispatchQueue.main.async {
                completion(mealMeUser!)
                // }
            }
            else{
                print("In NilUser")
                let nilUser = MealMeUser(name: "NilUser", userEmail: "NIL", zip: "", phone: "NIL", meals: [], reviews: [], totalRating: 0.0, numReviews: 0)
                completion(nilUser)
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
        let updatedUser = MealMeUser(name: chef.name, userEmail: chef.userEmail, zip: chef.zip, phone: chef.phone, meals: currMeals, reviews: chef.reviews, totalRating: chef.totalRating, numReviews: chef.numReviews)
        self.updateUser(user: updatedUser, userid: chefid)
    }

    
    func addReviewToChef(chefid: String, reviewID: String, rating: Float)
    {
        self.getUser(key: chefid, completion: { (chef) in
            
            var currReviews : [String]
            currReviews =  chef.reviews
            currReviews.append(reviewID)
            let updatedUser = MealMeUser(name: chef.name, userEmail: chef.userEmail, zip: chef.zip, phone: chef.phone, meals: chef.meals, reviews: currReviews, totalRating: chef.totalRating + rating, numReviews: chef.numReviews + 1)
            self.updateUser(user: updatedUser, userid: chefid)
        })
        
        
        }
    

    
}
