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
        users.child(user.uid).setValue(["name": user.displayName, "email": user.email, "phone": "N/A", "zip": 94086, "meals": [Meal]()])
    }
    
    func getUser(key : String, completion: @escaping (MealMeUser) -> Void) {
        var mealMeUser : MealMeUser?
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let dict = snapshot.value as? [String:Any?] {
                for item in dict {
                    if item.key == key {
                        if let val = item.value as? NSDictionary{
                            let curUser = MealMeUser(name: val["name"] as? String ?? "", userEmail: val["chefId"] as? String ?? "", zip: val["zip"] as? Int ?? 0, phone: val["phone"] as? String ?? "", meals: val["meals"] as?  [String] ?? [])
                            mealMeUser = curUser
                        }
                    }
                    
                    
                    /*if let val = item.value as? NSDictionary {
                        let meal = MealMeUser(name: val["name"] as? String ?? "", chefEmail: val["chefId"] as? String ?? "", avgRating: val["rating"] as? Float ?? 0.0)
                        meals.append(meal)*/
                }
                completion(mealMeUser!)
            }
            
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
}