# MealMe307 - Spring 2019
Contributers: Monica Ravichandran, Ryan Powell, Kalyan Vejalla, Anand Rajiv, Aniketh Bhat 

# Overview
This project is a iOS application called MealMe where the user can order food made by home chefs. The app handles eaters and chefs. The chefs can create their home cooked meal and advertise their meals on our platform. The eater can request food made by the chefs and contact them externally. The app does not handle platform messaging between the eaters and the chefs. 

# Packages Used
- Firebase Auth
- Firebase

# Important Directories
- MealMeTests/ and MealMeUITests/ contain all unit tests
- MealMe/ has all swift files

# Build
To build the application, open workspace in XCode or run 
```
xcodebuild clean -project MealMe.xcodeproj -scheme MealMe -destination "platform=iOS Simulator,name=iPhone X,OS=12.2" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO -quiet
```
XCode 10.2 and Swift 5 must be installed.
