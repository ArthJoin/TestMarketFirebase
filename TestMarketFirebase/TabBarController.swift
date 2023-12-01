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
        let createVC = CreateVC()
        let isLogin = UserDefaults.standard.object(forKey: "isLogin") as? Bool ?? false
//        let accountVC: UIViewController
//        if isLogin {
//            accountVC = AccountVC()
//        } else {
//            accountVC = SignInVC()
//        }
        let accountVC = SignInVC()
        
        let homeNavigation = NavBarController(rootViewController: homeVC)
        let createNavigation = NavBarController(rootViewController: createVC)
        let accountNavigation = NavBarController(rootViewController: accountVC)
        
        homeNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.home, image: UIImage(systemName: "homekit"), tag: Tabs.Home.rawValue)
        createNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.create, image: UIImage(systemName: "plus.viewfinder"), tag: Tabs.Wishlist.rawValue)
        accountNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.account, image: UIImage(systemName: "person"), tag: Tabs.Account.rawValue)
        
        
        setViewControllers([
            homeNavigation,
            createNavigation,
            accountNavigation
        ], animated: false)
    }
}
