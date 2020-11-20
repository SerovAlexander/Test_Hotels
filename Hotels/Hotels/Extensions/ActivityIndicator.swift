//
//  ActivityIndicator.swift
//
//  Created by Aleksandr Serov on 25.08.2020.
//  Copyright © 2020 Aleksandr Serov. All rights reserved.
//

import SnapKit
import UIKit


private var indicatorView: UIView?

extension UIView {

    func showActivityIndicator() {
        indicatorView = UIView(frame: self.bounds)
        indicatorView?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        if #available(iOS 13.0, *) {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.startAnimating()
            activityIndicator.center = indicatorView!.center
            indicatorView?.addSubview(activityIndicator)
            self.addSubview(indicatorView!)
        } else {
             let activityIndicator = UIActivityIndicatorView(style: .gray)
             activityIndicator.frame = self.frame
             activityIndicator.startAnimating()
             indicatorView?.addSubview(activityIndicator)
             self.addSubview(indicatorView!)
        }
    }

    func stopActivitiIndicator() {
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
}
