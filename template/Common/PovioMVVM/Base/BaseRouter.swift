//
//  BaseRouter.swift
//  template
//
//  Created by Dejan Skledar on 26/03/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import UIKit

class BaseRouter: NSObject {
  private var parentObersvation: NSKeyValueObservation?
  unowned var viewController: UIViewController
  private var temporaryRetainedViewController: UIViewController?
  
  var navigationController: UINavigationController? {
    viewController.navigationController
  }
  
  public init(viewController: UIViewController) {
    self.viewController = viewController
    self.temporaryRetainedViewController = viewController
    
    super.init()
    
    // This will clear the Retain Cycle of the ViewController when the View is presented/pushed on to the
    // navigation stack by observing the parent
    parentObersvation = viewController.observe(\.parent, options: [.new]) { [weak self] _, change in
      if change.newValue != nil {
        self?.temporaryRetainedViewController = nil
      }
    }
  }
}

// MARK: - Navigation
extension BaseRouter {
  func present(
    router: BaseRouter,
    animated: Bool = true,
    navigationControllerSetup: ((BaseNavigationController) -> Void)? = nil,
    completion: (() -> Void)? = nil
  ) {
    let navigationController = BaseNavigationController(router: router)
    
    // Custom additional navigation controller setup possible with callback
    navigationControllerSetup?(navigationController)
     
    viewController.present(navigationController, animated: animated, completion: completion)
  }
  
  func push(
    router: BaseRouter,
    animated: Bool = true,
    completion: (() -> Void)? = nil
  ) {
    navigationController?.pushViewController(router.viewController, animated: animated, completion: completion)
  }
  
  func setRoot(
    router: BaseRouter,
    animated: Bool = true
  ) {
    navigationController?.setViewControllers([router.viewController], animated: animated)
  }
  
  func popToRoot(animated: Bool = true) {
    navigationController?.popToRootViewController(animated: animated)
  }
}
