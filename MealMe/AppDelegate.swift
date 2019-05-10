//
//  AppDelegate.swift
//  MealMe
//
//  Created by Kalyan Vejalla on 4/7/19.
//  Copyright © 2019 Kalyan Vejalla. All rights reserved.
//

import Firebase
import GoogleSignIn


import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    let userDefault = UserDefaults()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    // Google sign in helper functions
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        print("sign in")
        if let error = error {
            print(error.localizedDescription)
            return
        }
        else
        {
            guard let authentication = user.authentication else {return}// when user signs in correctly, we capture the user info that google provides
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            
            // authenticate user to firebase
            Auth.auth().signInAndRetrieveData(with: credential) { (result, error) in
                if error == nil
                {
                    print(result?.user.email)
                    print(result?.user.displayName)
                    self.userDefault.set(true, forKey: "usersignedin")
                    self.userDefault.synchronize()
                    // make sure user goes to the right window when signed in
                    self.window?.rootViewController?.performSegue(withIdentifier: "SignInSegue", sender: nil)
                }
                else
                {
                    print(error?.localizedDescription)
                }
                
            }
            
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
    
     // Google sign in helper functions --  for iOS 8 and befiore
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    


}

