//
//  Alerts.swift
//
//  Created by Aleksandr Serov on 31.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import UIKit

class Alerts {

    static func presentAlert(view: UIView, viewController: UIViewController) {
        let alert = UIAlertController(title: "Нет соединения", message: "В данный момент наше приложение находится в режиме офлайн. Проверте подключение к интернету и повторите попытку", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            view.stopActivitiIndicator()
        }))

        viewController.present(alert, animated: true, completion: nil)
    }
}
