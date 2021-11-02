//
//  LocalDbModel.swift
//  landingPage
//
//  Created by Mohsen's iMac on 11/2/21.
//

import Foundation

struct PFObjectModel {
    
    var email: String?
    var language: Language.RawValue?
    var landingPage: LandingPage.RawValue?

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case language = "language"
        case landingPage = "landingPage"
    }
}


enum Language: String {
    case English            = "English"
    case French             = "French"
    case Turkish            = "Turkish"
    case Persian            = "Persian"
}

enum LandingPage: String {
    case Home             = "Home"
    case News             = "News"
    case Settings         = "Settings"
}

