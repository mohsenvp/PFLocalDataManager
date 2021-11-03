//
//  LocalDataManager.swift
//  landingPage
//
//  Created by Mohsen's iMac on 11/1/21.
//

import Foundation
import Parse


struct LocalDataManager{
    
    /// Get first object of local db by email address
    /// - Parameters:
    ///   - className database name
    ///   - email
    ///   - success: retun object
    ///   - failure: return error
    static func getFirstObject(className : String! , email: String!, success:@escaping (_ object : PFObject) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        let query = PFQuery(className: className)
        query.whereKey("email", equalTo: email.lowercased())
        query.fromLocalDatastore()
        query.getFirstObjectInBackground { object, error in
            if object != nil{
                success(object!)
            }else{
                failure(error!)
            }
        }
    }
    
    
    /// get all data exist in local db
    /// - Parameters:
    ///   - className: database name
    ///   - success: return array of objects
    ///   - failure: return NSError
    static func getAllData(className:String!, success:@escaping (_ objects : [PFObject]) -> Void, failure: @escaping (_ error: Error) -> Void){
        
        let query = PFQuery(className: className)
//        query.whereKey("email", equalTo: email.lowercased())
        query.fromLocalDatastore()
        query.findObjectsInBackground { objects, error in
            if error == nil{
                success(objects!)
            }else{
                failure(error!)
            }
            
        }
    }
    
    
    /// save an object in local database
    /// - Parameters:
    ///   - className: database name
    ///   - parameters: parameters that we need insert to db (email is unique key)
    ///   - success: return success
    ///   - failure: return error
    static func savingObjectInLocal(className : String, parameters : PFObjectModel? , success:@escaping (_ object : Bool) -> Void, failure: @escaping (_ error: Error) -> Void){

        let userPreferences = PFObject(className:className)
        userPreferences["email"] = parameters?.email!.lowercased()
        userPreferences["language"] = parameters?.language
        userPreferences["landingPage"] = parameters?.landingPage
        userPreferences.pinInBackground { response, error in
            if response{
                success(response)
            }else{
                failure(error!)
            }
        }
    }
    
    
    /// update an object in local database by email field
    /// - Parameters:
    ///   - className: database name
    ///   - parameters: landing/language optional update
    ///   - success: return success
    ///   - failure: return failed
    static func updateObjectInLocal(className : String, parameters : PFObjectModel? , success:@escaping (_ succes : Bool) -> Void, failure: @escaping (_ error: Error) -> Void){
        
        let query = PFQuery(className : className )
        query.fromLocalDatastore()
        query.whereKey("email", equalTo: (parameters?.email?.lowercased())!)
        query.findObjectsInBackground { objects , error in
            if objects != nil{
                for item in objects!{
                    if item["email"]! as! String == (parameters?.email?.lowercased())!{
                        if let landing = parameters?.landingPage {
                            item["landingPage"] = landing
                        }
                        if let language = parameters?.language{
                            item["language"] = language
                        }
                        item.pinInBackground()
                        success(true)
                    }
                }
            }else{
                failure(error!)
            }
        }
        
        
        
        
//        query.getFirstObjectInBackground { object, error in
//            if object != nil{
//                if let landing = parameters?.landingPage {
//                    object!["landingPage"] = landing
//                }
//                if let language = parameters?.language{
//                    object!["language"] = language
//                }
//                object!.pinInBackground()
//                success(true)
//            }else{
//                failure(error!)
//            }
//        }
    }
    
    
    
    
    
    
//    PFObject.deleteAll(inBackground: objectArray) { (succeeded, error) in
//        if (succeeded) {
//            // The array of objects was successfully deleted.
//        } else {
//            // There was an error. Check the errors localizedDescription.
//        }
//    }

//    gameScore.unpinInBackground()
//
//    PFObject.unpinAllInBackground(listOfObjects)
   
//    deleteInBackgroundWithBlock
    

//
//    func updateObjectInCloud(className : String, email : String){
//        let query = PFQuery(className : className )
//        query.getObjectInBackground(withId: email) { (object: PFObject?, error: Error?) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let object = object {
//                object["cheatMode"] = true
//                object["score"] = 1338
//                object.saveInBackground()
//            }
//        }
//    }
   
//    func savingObjectInCloud(className : String){
//        let userPreferences = PFObject(className: className)
//        userPreferences["userId"] = UIDevice.current.identifierForVendor?.uuidString ?? ""
//        userPreferences["language"] = "English"
//        userPreferences["landingPage"] = "News"//"Home"
//
//        userPreferences.saveInBackground { (succeeded, error)  in
//            if (succeeded) {
//                // The object has been saved.
//            } else {
//                // There was a problem, check error.description
//            }
//        }
//    }
//
    

//    static func getFirstObjectInCloud(className: String){
//        let query = PFQuery(className: className)
//        query.getFirstObjectInBackground { object, error in
//            if object != nil{
//
////                let landingPage = object!.object(forKey: "landingPage")! as? String
////                if landingPage == "Home"{
////                    self.selectedIndex = 0
////                }else{
////                    self.selectedIndex = 1
////                }
//            }else{
//
//            }
//        }
//    }
//

}
