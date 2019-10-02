//
//  UIViewController+.swift
//  iOS MVC
//
//  Created by trinh.giang.dong on 10/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    /// Show alert with error message.
    ///
    /// - Parameters:
    ///   - message: Message will show on Alert.
    ///   - completion: complation block will implemente when alert is closed.
    func showError(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    /// Remove back button on NavigationBar.
    func removeBackButtonTitle() {
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    /// Get top most viewController is currently presenting.
    ///
    /// - Returns: UIViewController on the top of stack.
    func topMostViewController() -> UIViewController? {
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController()
        }
        
        if let tab = self as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            if let visibleController = navigation.visibleViewController {
                return visibleController.topMostViewController()
            }
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController?.topMostViewController()
    }
    
    /// Show a progress indicator on screen.
    ///
    /// - Parameter isLoading: `true` if want to show and `false` if want to dismiss.
    func showIndicator(_ isLoading: Bool) {
        if isLoading {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.offset.y = -30
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
}
