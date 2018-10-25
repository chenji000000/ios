//
//  AppDelegate.swift
//  CJProject
//
//  Created by 陈吉 on 2018/10/24.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let tab = self.customTabBarController()
        self.window?.rootViewController = tab
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func customTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let homeController = CJHomeViewController()
        homeController.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        let homeNav = UINavigationController(rootViewController: homeController)
        
        let listenController = CJListenViewController()
        listenController.tabBarItem = UITabBarItem(title: "我听", image: UIImage(named: "photo"), selectedImage: UIImage(named: "photo_1"))
        let listenNav = UINavigationController(rootViewController: listenController)
        
        let playController = CJPlayViewController()
        playController.tabBarItem = UITabBarItem(title: "播放", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        let playNav = UINavigationController(rootViewController: playController)
        
        let findController = CJFindViewController()
        findController.tabBarItem = UITabBarItem(title: "发现", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        let findNav = UINavigationController(rootViewController: findController)
        
        let mineController = CJMineViewController()
        mineController.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        let mineNav = UINavigationController(rootViewController: mineController)
        
        tabBarController.viewControllers = [homeNav, listenNav, playNav, findNav, mineNav]
        
        return tabBarController
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

