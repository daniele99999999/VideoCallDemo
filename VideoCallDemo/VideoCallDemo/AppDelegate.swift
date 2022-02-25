//
//  AppDelegate.swift
//  VideoCallDemo
//
//  Created by Daniele Salvioni on 19/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoordinator: CoordinatorProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Resources.UI.Appearance.navBar()
        
        let mainVC = UINavigationController()
        self.mainCoordinator = MainCoordinator(rootController: mainVC)
        self.mainCoordinator?.start()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

