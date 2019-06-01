//
//  Search.swift
//  MealMe
//
//  Created by Monica Ravichandran on 5/31/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn
import UIKit
class Search{
    
    let ref = Database.database().reference()
    //let zipcode:String?
    
    func searchByKeywords(keyword: String) -> [Meal]{
        
        let userHandler = UserTableHandler()
        let mealHandler = MealTableHandler()
        let id = Auth.auth().currentUser?.uid
        var zipcode = 0
        let dispatch = DispatchGroup()
        var meals = [Meal]()

        dispatch.enter()
        DispatchQueue.main.async {
            
            //userHandler.getUser(key: id!) { (myUser) in
            //    zipcode = myUser.zip
            //    dispatch.leave()
            //}
            mealHandler.getMeals(keyword: keyword, completion: { (mealsArr) in
                meals = mealsArr
            })
            
        }
        
        dispatch.notify(queue: .main) {
            return meals
            
        }
        
        
        
        
        return []
    }
    func searchHelper(zipcode:Int){
        var postal_codes = [Int]()
        let str_zip = String(zipcode)
        let str_url = "http://api.geonames.org/findNearbyPostalCodesJSON?postalcode="+str_zip+"&country=US&radius=30&username=monicar2u&maxRows=50"
        print(str_url)
        var flag = true
        var counter = 0
        repeat{
            let req = NSMutableURLRequest(url: NSURL(string:str_url)! as URL)
            let ses = URLSession.shared
            req.httpMethod = "GET"
            let task = ses.dataTask(with: req as URLRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    return
                }
                guard let data = data else {
                    return
                }
                do {
                    // let jsonData:NSArray = ((try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray)!)
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] {
                        print("inside")
                        if let data = json["postalCodes"] as? [Any] {
                            postal_codes = self.get_codes(json: data)
                            flag = false
                            
                        }
                    }
                } catch let error {
                    print("not working")
                    print(error.localizedDescription)
                }
            })
            
            task.resume()
            counter+=1
            print(counter)
        } while(flag)
        
    }
    func get_codes(json:[Any]) -> [Int]{
            for item in json{
                let dict = item as? NSDictionary
                print(dict?.value(forKey: "postalCode"))
            }
  
        //let json_parsed = json["postalCodes"] as! [String:Any]
        //for item in json_parsed{
         //   print(item)
       // }
        //print(json)
        /*
        guard let array = json as? [Any] else { return }
        
        for item in array {
            guard let quizObjects = item as? [String: Any] else { return }
            guard let questionNumber = quizObjects["id"] as? Int else { print("not an Int"); return }
            guard let question = quizObjects["question"] as? String else { return }
            guard let answerChoices = quizObjects["answerChoices"] as? [String] else { return }
            guard let correctAnswer = quizObjects["correctAnswer"] as? Int else { return }
        */
        //let array = json as? [Any]
       /*
        for item in json_parsed!{
            print(item)
            break
        }
        */
        
        return [1]
    }
        
}
