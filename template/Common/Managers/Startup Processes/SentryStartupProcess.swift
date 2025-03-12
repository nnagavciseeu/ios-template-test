//
//  SentryStartupProcess.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import PovioKitCore
import Sentry

final class SentryStartupProcess: StartupProcess {
  func run(completion: @escaping (Bool) -> Void) {
    defer { completion(true) }
    SentrySDK.start { options in
      options.dsn = Constants.Configuration.Sentry.DNS
      options.environment = Constants.Environment.current.rawValue
      options.debug = false // Constants.Environment.current == .dev && Constants.Environment.isDebug
      options.attachScreenshot = true
    }
  }
}
