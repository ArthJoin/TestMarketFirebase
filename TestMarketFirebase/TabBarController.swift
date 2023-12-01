//
//  TabBarController.swift
//  TestMarketFirebase
//
//  Created by Артур Наврузов on 01.12.2023.
//

import UIKit

enum Tabs: Int {
    case Home
    case Wishlist
    case Account
}

final class TabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func configure() {
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inactive
        tabBar.backgroundColor = .black
                
        let homeVC = HomeVC()
        let wishlistVC = WishlistVC()
        let accountVC = AccountVC()
        
        let homeNavigation = NavBarController(rootViewController: homeVC)
        let wishlistNavigation = NavBarController(rootViewController: wishlistVC)
        let accountNavigation = NavBarController(rootViewController: accountVC)
        
        homeNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home, image: UIImage(systemName: "homekit"), tag: Tabs.Home.rawValue)
        wishlistNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.wishlist, image: UIImage(systemName: "heart"), tag: Tabs.Wishlist.rawValue)
        accountNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.account, image: UIImage(systemName: "person"), tag: Tabs.Account.rawValue)
        
        
        setViewControllers([
            homeNavigation,
            wishlistNavigation,
            accountNavigation
        ], animated: false)
    }
}
