//
//  MainTabBarController.swift
//  InstragramFirebase
//
//  Created by freddy on 04/02/2018.
//  Copyright © 2018 jamfly. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        
        let userProfileNav = UINavigationController(rootViewController: userProfileController)
        
        userProfileNav.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        userProfileNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        signUpController.tabBarItem.image = 
        
        tabBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        viewControllers = [userProfileNav, ViewController()]
    }
    
    
    
}




