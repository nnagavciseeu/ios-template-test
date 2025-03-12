//
//  UINavigationController+pushViewController.swift
//  template
//
//  Created by Dejan Skledar on 30/07/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import UIKit

extension UINavigationController {
  public func pushViewController(
    _ viewController: UIViewController,
    animated: Bool,
    completion: (() -> Void)?
  ) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    pushViewController(viewController, animated: animated)
    CATransaction.commit()
  }
}
