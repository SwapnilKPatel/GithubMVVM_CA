//
//  AppDelegate.swift
//  GithubMVVM_CA
//
//  Created by Ravi on 10/03/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Create the initial view controller
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = GitHubViewController() // Your initial ViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Pause ongoing tasks, disable timers, etc.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Save data and release shared resources
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Undo changes made when entering background
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart paused tasks
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Save data if needed
    }
}
