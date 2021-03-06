//
//  SceneDelegate.swift
//
//  Created by Aleksandr Serov on 23.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowsScene.coordinateSpace.bounds)
        self.window?.windowScene = windowsScene
        self.window?.makeKeyAndVisible()
        let mainViewController = HotelListTVC(nibName: nil, bundle: nil)
        let navigationViewController = UINavigationController(rootViewController: mainViewController)
        self.window?.rootViewController = navigationViewController
    }
}
