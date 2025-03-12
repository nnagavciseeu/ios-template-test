//
//  HostingNavigationController.swift
//  template
//
//  Created by Dejan Skledar on 26/03/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import UIKit

class HostingNavigationController: UINavigationController {
  override public func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
    guard let hostingChild = children.last as? HostingNavigationConfigurable
    else {
      // In case the last pushed controller is not a HostingNavigationConfigurable,
      // we can simply call super here since we're not dealing with SwiftUI
      // but with regular UIKit.
      super.setNavigationBarHidden(hidden, animated: animated)
      return
    }
    
    super.setNavigationBarHidden(hostingChild.shouldHideNavigationBar, animated: animated)
  }
}
