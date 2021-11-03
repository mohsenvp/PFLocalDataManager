//
//  SceneDelegate.swift
//  landingPage
//
//  Created by Mohsen's iMac on 10/31/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        handleUserPreferences()

        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    fileprivate func handleUserPreferences() {

        LocalDataManager.getFirstObject(className: Landing.userLocalDBName, email: Landing.userEmail) {object in
            print(object)
            _ = object.object(forKey: "language")! as! String
            let landingPage : String = object.object(forKey: "landingPage")! as! String
            print(landingPage)
            
            let board = UIStoryboard(name: "Main", bundle: nil)
                      let TabBarViewController = board.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            self.window?.rootViewController = TabBarViewController
//            if landingPage == LandingPage.Home.rawValue{
//                self.selectedIndex = 0
//            }
            switch landingPage{
            case "Home":
                TabBarViewController.selectedIndex = 0
                break
            case "News":
                TabBarViewController.selectedIndex = 1
                break
            case "Settings":
                TabBarViewController.selectedIndex = 2
                break
            default:
                TabBarViewController.selectedIndex = 2
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

