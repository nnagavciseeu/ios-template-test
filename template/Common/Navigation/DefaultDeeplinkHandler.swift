//
//  DefaultDeeplinkHandler.swift
//  template
//
//  Created by Dejan Skledar on 06/12/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import UIKit

enum DeepLinkActions: String {
  case none = "NONE"
}

struct DefaultDeeplinkHandler {
  let flowController: FlowController
}

extension DefaultDeeplinkHandler: DeepLinkHandling {
  func handle(continue userActivity: NSUserActivity) {
    handle(dynamicLinkUrl: userActivity.webpageURL)
  }
}

private extension DefaultDeeplinkHandler {
  func handle(dynamicLinkUrl: URL?) {
    guard let url = dynamicLinkUrl,
          let deeplinkAction = DeepLinkActions(rawValue: url.path) else { return }
    
    switch deeplinkAction {
    default:
      break
    }
  }
}
