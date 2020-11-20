//
//  AppDelegate.swift
//
//  Created by Aleksandr Serov on 23.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        let mainViewController = HotelListTVC(nibName: nil, bundle: nil)
        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        self.window?.rootViewController = navigationViewController

        return true
    }
}
