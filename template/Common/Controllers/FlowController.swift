//
//  FlowController.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import UIKit

protocol AppVersionEnforcer {
  func ensureAppVersionIsValid()
}

class FlowController {
  let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
    self.window.makeKeyAndVisible()
  }
}

// MARK: - Public Methods
extension FlowController {
  func startAppFlow() {
    window.rootViewController = splashViewController
  }

  func continueFlow() {
    // TODO: Continue app flow
  }
}

// MARK: - Private Methods
private extension FlowController {
  var splashViewController: UIViewController {
    let splashRouter = SplashRouter(
      input: .init { [weak self] in
        self?.continueFlow()
      }
    )
    return splashRouter.viewController
  }
}
