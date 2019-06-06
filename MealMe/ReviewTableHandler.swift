//
//  ReviewTableHandler.swift
//  MealMe
//
//  Created by Kalyan Vejalla on 6/2/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import Foundation
import Firebase

class ReviewTableHandler {
    let ref = Database.database().reference()
    
    func addReviewToChef(review: Review) {
        let reviews = ref.child("reviews")
        reviews.child(review.reviewId).setValue(["reviewId": review.reviewId, "rating": review.rating, "review": review.text, "eaterName": review.eaterName, "eaterId": review.eaterId, "chefId": review.chefId])
    }
    
    func getReviewsForChef(chefID: String, completion: @escaping ([Review]) -> Void) {
        var reviews = [Review]()
        ref.child("reviews").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let dict = snapshot.value as? [String:Any?] {
                for item in dict {
                    if let val = item.value as? NSDictionary {
                        var valChefId = val["chefId"] as? String ?? ""
                        if(valChefId == chefID){  //.equals(chefID)){
                            let currReview = Review(reviewId: val["reviewId"] as? String ?? "", rating: Double(val["rating"] as? Float ?? 0.0), text: val["review"] as? String ?? "", eaterName: val["eaterName"] as? String ?? "",  eaterId: val["eaterId"] as? String ?? "", chefId: val["chefId"] as? String ?? "")
                            reviews.append(currReview)
                        }
                    }
                    
                }
            }
            
            completion(reviews)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
