//
//  SettingsViewController.swift
//  landingPage
//
//  Created by Mohsen's iMac on 10/31/21.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    @IBOutlet weak var landingButton: UIButton!
    @IBOutlet weak var languageButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    var viewModel = settingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        LocalDataManager.getFirstObjectInLocalDataStore(className: Landing.userLocalDBName, email: Landing.userEmail) { object in
            print(object)
            let language = object.object(forKey: "language")
            self.textLabel.text = "Currently your preferd language is \(language!)"
            
        } failure: { error in
            print(error)
        }

        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func callLocalManager(_ userPreferences: PFObjectModel) {
        LocalDataManager.getFirstObjectInLocalDataStore(className: Landing.userLocalDBName, email: Landing.userEmail) { object in
            
            LocalDataManager.updateUserPreferencesInLocalDataStore(className: Landing.userLocalDBName, parameters: userPreferences) { succes in
                let alert = UIAlertController(title: "Success", message: "Your language changed to \(userPreferences.language != nil ? userPreferences.language! : userPreferences.landingPage! )", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: { (_) in
                }))
                self.present(alert, animated: true, completion: nil)
                if userPreferences.language != nil{
                    self.textLabel.text = "Currently your preferd language is \(userPreferences.language!)"
                }

            } failure: { error in
                
            }
            
        } failure: { error in
            LocalDataManager.savingUserPreferencesInLocalDataStore(className: Landing.userLocalDBName, parameters: userPreferences) { object in
                
            } failure: { error in
                
            }
            
        }
    }
    
    @IBAction func getAllLocalDBButton(_ sender: Any) {
        LocalDataManager.getAllDataInLocalDataStore(className: Landing.userLocalDBName) { objects in
            for item in objects{
                print(item)
            }
        } failure: { error in
            
        }

    }
    
    @IBAction func changePreferdLanguageButton(_ sender: UIButton) {
        
        var userPreferences = PFObjectModel()
        userPreferences.email = Landing.userEmail

        if sender.tag == 0{
            userPreferences.language = Language.English.rawValue
            sender.backgroundColor = .red
        }else if sender.tag == 1{
            userPreferences.language = Language.French.rawValue

        }else if sender.tag == 2{
            userPreferences.language = Language.Turkish.rawValue

        }else{
            userPreferences.language = Language.Persian.rawValue
        }
        
        callLocalManager(userPreferences)

    }

    @IBAction func buttonAction(_ sender: UIButton) {
        var userPreferences = PFObjectModel()
        userPreferences.email = Landing.userEmail
//        userPreferences.language = Language.English.rawValue

        if sender.tag == 0{
            userPreferences.landingPage = LandingPage.Home.rawValue

        }else if sender.tag == 1{
            userPreferences.landingPage = LandingPage.News.rawValue

        }else{
            userPreferences.landingPage = LandingPage.Settings.rawValue

        }
        
        callLocalManager(userPreferences)

    }
    
}
