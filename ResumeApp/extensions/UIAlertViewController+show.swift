//
//  UIAlertViewController+show.swift
//  ResumeApp
//
//  Created by Chibundu Anwuna on 2019-06-20.
//  Copyright © 2019 NormBreakers. All rights reserved.
//

import UIKit

public extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}
