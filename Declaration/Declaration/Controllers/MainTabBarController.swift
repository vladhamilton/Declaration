//
//  MainTabBarController.swift
//  Declaration
//
//  Created by Vladyslav Kolomiets on 12/27/19.
//  Copyright © 2019 Vladyslav Kolomiets. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setupStyle()
    }
    
    // MARK: - private
    
    private func setupViewControllers() {
        viewControllers = [generateViewController(rootViewController: SearchViewController(), image: #imageLiteral(resourceName: "Search"), title: "Search"), generateViewController(rootViewController: FavoritesViewController(), image: #imageLiteral(resourceName: "star_filled"), title: "Favorites")]
    }
    
    private func setupStyle() {
        tabBar.tintColor = #colorLiteral(red: 0.9921568627, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        navigationViewController.tabBarItem.image = image
        navigationViewController.tabBarItem.title = title
        return navigationViewController
    }
}
