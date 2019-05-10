//
//  SignedIn.swift
//  MealMe
//
//  Created by Kalyan Vejalla on 5/8/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import Foundation

func signOutPressed(_ sender: Any)
{
    do {
        try Auth.auth().signOut()
        UserDefault.removeObject
    }
}
