//
//  TabBarController.swift
//  Unit4Assessment
//
//  Created by Lilia Yudina on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class TabBarController: UITabBarController {
    
    private var dataPersistence = DataPersistence<FlashCard>(filename: "userCards.plist")
    
    private var userPreference = UserPreference()
    
    
    private lazy var userCardCollectionVC: UserCardCollectionController = {
        let viewController = UserCardCollectionController()
          viewController.dataPersistence = dataPersistence
        viewController.dataPersistence.delegate = viewController
        viewController.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "message"), tag: 0)
              
        return viewController
    }()
    
    private lazy var createAFlashCardVC: CreateAFlashCardViewController = {
        let viewController = CreateAFlashCardViewController()
               
     
        viewController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        return viewController
    }()
    
    private lazy var flashCardCollectionVC: FlashCardCollectionViewController = {
        let viewController = FlashCardCollectionViewController()
     
        viewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
                viewController.dataPersistence = dataPersistence
                   viewController.userPreference = userPreference
        viewController.userPreference.delegate = viewController
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [UINavigationController(rootViewController: userCardCollectionVC), UINavigationController(rootViewController: createAFlashCardVC), UINavigationController(rootViewController: flashCardCollectionVC)]
    }
    
    
}
