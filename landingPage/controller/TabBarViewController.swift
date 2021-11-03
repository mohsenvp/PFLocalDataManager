//
//  TabBarViewController.swift
//  landingPage
//
//  Created by Mohsen's iMac on 10/31/21.
//

import UIKit
import Parse

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.darkGray
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .lightGray
    }
    
}
