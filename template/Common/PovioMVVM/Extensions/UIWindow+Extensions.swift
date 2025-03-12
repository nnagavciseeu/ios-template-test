//
//  UIWindow+Extensions.swift
//  template
//
//  Created by Dejan Skledar on 30/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import UIKit

extension UIWindow {
  func setRootRouterAnimated(_ router: BaseRouter, completion: (() -> Void)? = nil) {
    let navigationController = BaseNavigationController(router: router)
    setRootViewControllerAnimated(navigationController, completion: completion)
  }
  
  func setRootViewControllerAnimated(
    _ vc: UIViewController,
    duration: TimeInterval = 0.5,
    completion: (() -> Void)? = nil
  ) {
    rootViewController = vc
    UIView.transition(
      with: self,
      duration: duration,
      options: .transitionCrossDissolve,
      animations: {},
      completion: { _ in
        completion?()
      }
    )
  }
}
