//
//  AppDelegate.swift
//  towa-exam
//
//  Created by Nico Aurelio Villanueva on 7/5/22.
//

import UIKit

let session = Session.shareSession
let request = APIServices()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 13, *) {
            // do only pure app launch stuff, not interface stuff
       } else {
           
           let window = UIWindow(frame: UIScreen.main.bounds)
           
           let viewController = OnBoardingViewController()
           let navigation = UINavigationController(rootViewController: viewController)

           UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)

           UINavigationBar.appearance().backgroundColor = R.color.main_background()

           UINavigationBar.appearance().barTintColor = R.color.main_background()

           navigation.navigationBar.tintColor = R.color.accent_light_color()

           window.backgroundColor = R.color.main_background()

           window.rootViewController = navigation
           
           window.makeKeyAndVisible()

           self.window = window
           
           return true
       }
        
       return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

