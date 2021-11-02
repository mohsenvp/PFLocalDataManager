//
//  TabBarViewController.swift
//  landingPage
//
//  Created by Mohsen's iMac on 10/31/21.
//

import UIKit
import Parse

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    var previousTabIndex = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.darkGray
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
//        self.selectedIndex = 2
        
        
        
        handleUserPreferences()
    }
    
    
    fileprivate func handleUserPreferences() {

        LocalDataManager.getFirstObject(className: Landing.userLocalDBName, email: Landing.userEmail) {object in
            print(object)
            _ = object.object(forKey: "language")! as! String
            let landingPage : String = object.object(forKey: "landingPage")! as! String
            print(landingPage)
//            if landingPage == LandingPage.Home.rawValue{
//                self.selectedIndex = 0
//            }
            switch landingPage{
            case "Home":
                self.selectedIndex = 0
                break
            case "News":
                self.selectedIndex = 1
                break
            case "Settings":
                self.selectedIndex = 2
                break
            default:
                self.selectedIndex = 2
            }
        } failure: { error in
            print(error.localizedDescription)
            var userPreferences = PFObjectModel()
            userPreferences.email = Landing.userEmail
            userPreferences.language = Language.English.rawValue
            userPreferences.landingPage = LandingPage.Home.rawValue
    
            LocalDataManager.savingObjectInLocal(className: Landing.userLocalDBName, parameters: userPreferences) { object in
                print(object)
            } failure: { error in
                print(error)
            }
        }
    }
    
}
