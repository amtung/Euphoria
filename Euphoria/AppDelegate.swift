//
//  AppDelegate.swift
//  Euphoria
//
//  Created by Annie Tung on 12/14/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        
       /* self.window = UIWindow(frame: UIScreen.main.bounds)
//        let rootVC = EventsTableViewController()
        let navigationController = UINavigationController(rootViewController: EventsTableViewController())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()*/
        
       /* self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        
        var initialNavController = UINavigationController()
        initialNavController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 0)
//        var eventsVC = EventsTableViewController(nibName: nil, bundle: nil)
        let navViewController = UINavigationController(rootViewController: initialNavController)
        tabBarController.viewControllers?.append(navViewController)
//        initialNavController.viewControllers = [eventsVC]
        
        var secondNavController = UINavigationController()
        secondNavController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 1)
//        var musicVC = MusicViewController(nibName: nil, bundle: nil)
//        secondNavController.viewControllers = [musicVC]
        let navViewControllerOne = UINavigationController(rootViewController: secondNavController)
        tabBarController.viewControllers?.append(navViewControllerOne)
        
        tabBarController.viewControllers = [initialNavController, secondNavController]
        tabBarController.selectedIndex = 0
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()*/
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        
        let eventsVC = EventsViewController(nibName: nil, bundle: nil)
        let eventsNavController = UINavigationController(rootViewController: eventsVC)
        
        let profileVC = MusicViewController(nibName: nil, bundle: nil)
        let homeVC = HomeViewController(nibName: nil, bundle: nil)
        let controllers = [eventsNavController,homeVC,profileVC]
        tabBarController.viewControllers = controllers
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        /*
        let firstImage = UIImage(named: "pie bar icon")
        let secondImage = UIImage(named: "pizza bar icon")
        myVC1.tabBarItem = UITabBarItem(
            title: "Pie",
            image: firstImage,
            tag: 1)
        myVC2.tabBarItem = UITabBarItem(
            title: "Pizza",
            image: secondImage,
            tag:2)*/
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.bookmarks, tag: 0)
        eventsVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.contacts, tag: 1)
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.featured, tag: 2)
        tabBarController.selectedIndex = 0
 
        return true
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

