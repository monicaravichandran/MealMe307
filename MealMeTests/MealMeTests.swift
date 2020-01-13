//
//  MealMeTests.swift
//  MealMeTests
//
//  Created by Kalyan Vejalla on 4/7/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import XCTest
@testable import MealMe

class MealMeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMeal() {
        let m1 = Meal(mealId: "1234", name: "cookie", chefId: "ryan", zipcode: "94086", description: "its a cookie", ingredients: "chocolate", time: "1", servingSize: "1", price: "2.45", keywords: "a b c d", active: true)
        XCTAssertEqual(m1.mealId, "1234")
        XCTAssertEqual(m1.chefId, "ryan")
    }
    
    func testUser() {
        let u1 = MealMeUser(name: "ryan", userEmail: "rpowell311@gmail.com", zip: "93410", phone: "555555", meals: ["id1", "id2", "id3"], reviews: ["a", "b", "c"], totalRating: 3.3, numReviews: 3)
        XCTAssertEqual(u1.name, "ryan")
        XCTAssertEqual(u1.zip, "93410")
    }
  
    func testReview() {
        let r1 = Review(reviewId: "123", rating: 4, text: "dece", eaterName: "ryan", eaterId: "1234", chefId: "4321")
        XCTAssertEqual(r1.rating, 4)
        XCTAssertEqual(r1.eaterId, "1234")
    }
    
    func testGetReviews() {
        ReviewTableHandler().getReviewsForChef(chefID: "VV3qOoOkcQPyIyu45poBDClm2le2", completion: {(reviews) in
            XCTAssertEqual(reviews.count, 7)
        })
    }
    
    func testAddReview() {
        let r1 = Review(reviewId: "123", rating: 4, text: "dece", eaterName: "ryan", eaterId: "1234", chefId: "SRoF2D32BNYUPZsBwkjFsjO0O772")
        ReviewTableHandler().addReviewToChef(review: r1)
        print("REVIEWS COUNT")
        ReviewTableHandler().getReviewsForChef(chefID: "SRoF2D32BNYUPZsBwkjFsjO0O772", completion: {(reviews) in
            XCTAssertEqual(reviews.count, 1)
        })
    }
    
    func testUpdateUser() {
        let u1 = MealMeUser(name: "ryan", userEmail: "rpowell311@gmail.com", zip: "93410", phone: "555555", meals: ["id1", "id2", "id3"], reviews: ["a", "b", "c"], totalRating: 3.3, numReviews: 3)
        UserTableHandler().updateUser(user: u1, userid: "SRoF2D32BNYUPZsBwkjFsjO0O772")
        UserTableHandler().getUser(key: "SRoF2D32BNYUPZsBwkjFsjO0O772", completion: {(mealMeUser) in
            XCTAssertEqual(mealMeUser.zip, "93410")})
    }
    
    func testGetMealsAll() {
        MealTableHandler().getMeals(completion: {(meals) in
            XCTAssertEqual(meals.count, 5)
        })
    }
    
    func testGetMealsRefined() {
        MealTableHandler().getMeals(zipcode: "93405", keyword: "pizza", completion: {(meals) in
            XCTAssertEqual(meals.count, 2)
        })
    }
    
    func testAddMealToChef() {
        let u1 = MealMeUser(name: "ryan", userEmail: "rpowell311@gmail.com", zip: "93410", phone: "555555", meals: ["id1", "id2", "id3"], reviews: ["a", "b", "c"], totalRating: 3.3, numReviews: 3)
        UserTableHandler().addMealToChef(chef: u1, chefid: "SRoF2D32BNYUPZsBwkjFsjO0O772", mealid: "abcd")
        MealTableHandler().getMeals(chefId: "SRoF2D32BNYUPZsBwkjFsjO0O772", completion: {(meals) in
                XCTAssertEqual(meals.count, 0)
            })
    }
    
    func testGetUser() {
        UserTableHandler().getUser(key: "SRoF2D32BNYUPZsBwkjFsjO0O772", completion: {(user) in
                XCTAssertEqual(user.name, "ryan")
        })
    }
    
    func testGetReviewsPerformance() {
        self.measure {
            ReviewTableHandler().getReviewsForChef(chefID: "VV3qOoOkcQPyIyu45poBDClm2le2", completion: {(reviews) in
            })
        }
    }
    
    func testAddReviewPerformance() {
        self.measure {
            let r1 = Review(reviewId: "123", rating: 4, text: "dece", eaterName: "ryan", eaterId: "1234", chefId: "SRoF2D32BNYUPZsBwkjFsjO0O772")
            ReviewTableHandler().addReviewToChef(review: r1)
            ReviewTableHandler().getReviewsForChef(chefID: "SRoF2D32BNYUPZsBwkjFsjO0O772", completion: {(reviews) in
            })
        }
    }
    
    func testGetUserPerformance() {
        self.measure {
             UserTableHandler().getUser(key: "SRoF2D32BNYUPZsBwkjFsjO0O772", completion: {(user) in})
        }
    }

    func testIntegrationUserAndReviewTable() {
        UserTableHandler().getUser(key: "SRoF2D32BNYUPZsBwkjFsjO0O772", completion: {(mealMeUser) in
            ReviewTableHandler().addReviewToChef(review: Review(reviewId: "123", rating: 4, text: "dece", eaterName: "ryan", eaterId: "1234", chefId: "4321"))
            ReviewTableHandler().getReviewsForChef(chefID: "SRoF2D32BNYUPZsBwkjFsjO0O772", completion: {(reviews) in
                XCTAssertEqual(reviews.count, 2)
            })
        })
    }
    
    func testIntegrationMealAndReviewTable() {
        MealTableHandler().getMeals(completion: {(meals) in
            ReviewTableHandler().addReviewToChef(review: Review(reviewId: "123", rating: 4, text: "dece", eaterName: "ryan", eaterId: "1234", chefId: "4321"))
            ReviewTableHandler().getReviewsForChef(chefID: "SRoF2D32BNYUPZsBwkjFsjO0O772", completion: {(reviews) in
                XCTAssertEqual(reviews.count, 2)
            })
        })
    }
}
