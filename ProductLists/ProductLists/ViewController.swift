//
//  ViewController.swift
//  ProductLists
//
//  Created by Valter Louro on 11/04/2024.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .customTabBarColor
        self.tabBar.barTintColor = .customTabBarColor
        self.tabBar.tintColor = .customTabBarTintColor
        self.tabBar.unselectedItemTintColor = .customTabBarUnselectedItem
        self.navigationController?.navigationBar.backgroundColor = .customTabBarColor
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.customBarTintColor ?? UIColor.white]
        self.setupTabControllers()
    }

    func setupTabControllers(){
        // Set up the Product List View Controller
        let navigationController = UINavigationController(rootViewController: ProductListViewController())
        
        //Icons
        let productIcon = UITabBarItem(title: "List", image: UIImage(named: "headphones"), selectedImage: UIImage(named: "headphones"))
        navigationController.tabBarItem = productIcon
        
        let controllers = [navigationController]
        self.viewControllers = controllers
    }

}

extension ViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}

