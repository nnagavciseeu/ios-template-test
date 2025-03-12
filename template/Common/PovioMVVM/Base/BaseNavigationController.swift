//
//  BaseNavigationController.swift
//  template
//
//  Created by Dejan Skledar on 26/03/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import SwiftUI
import UIKit

class BaseNavigationController: HostingNavigationController {
  /// The background color for the `navigationBar`. Setting this sets the background color to all apperances
  var navigationBarBackgroundColor: UIColor? {
    get {
      navigationBar.standardAppearance.backgroundColor
    }
    set {
      navigationBar.standardAppearance.backgroundColor = newValue
      navigationBar.compactAppearance?.backgroundColor = newValue
      navigationBar.scrollEdgeAppearance?.backgroundColor = newValue
    }
  }
  
  /// The tint color for the `navigationBar`. Setting this sets the tint color to all apperances
  var navigationBarTintColor: UIColor? {
    get {
      navigationBar.tintColor
    }
    set {
      navigationBar.tintColor = newValue
      navigationBar.standardAppearance.titleTextAttributes[.foregroundColor] = newValue
      navigationBar.scrollEdgeAppearance?.titleTextAttributes[.foregroundColor] = newValue
    }
  }
  
  /// Set to `true` by default, hides the back button title. Set to `false`, to show the default title
  var hidesBackButtonTitle: Bool {
    true
  }
  
  /// The back button image for the `navigationBar`. Setting this sets the back button image to all apperances,
  /// By default, `nil` which uses the native system back button image
  var backButtonImage: UIImage? {
    nil
  }
  
  convenience init(router: BaseRouter) {
    self.init()
    setViewControllers([router.viewController], animated: true)
    setupUI()
  }
  
  // Overriding to remove the back button title if needed
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    if hidesBackButtonTitle {
      topViewController?.navigationItem.backButtonTitle = ""
    }
    super.pushViewController(viewController, animated: animated)
  }
}

// MARK: - Private Methods
private extension BaseNavigationController {
  func setupUI() {
    let appearance = UINavigationBarAppearance()
    appearance.shadowColor = .clear
    appearance.backgroundImage = .init()
    appearance.backgroundEffect = .none
    
    if let backButtonImage {
      appearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
    }
    
    navigationBar.standardAppearance = appearance
    navigationBar.scrollEdgeAppearance = appearance
    navigationBar.isTranslucent = true
  }
}
