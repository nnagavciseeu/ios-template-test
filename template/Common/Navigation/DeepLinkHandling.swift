//
//  DeepLinkHandling.swift
//  template
//
//  Created by Dejan Skledar on 06/12/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import UIKit

protocol DeepLinkHandling {
  func handle(continue userActivity: NSUserActivity)
}

extension Array where Element == DeepLinkHandling {
  func handle(continue userActivity: NSUserActivity) {
    forEach { $0.handle(continue: userActivity) }
  }
}
