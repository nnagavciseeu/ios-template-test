//
//  LoggerStartupProcess.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import PovioKitCore

class LoggerStartupProcess: StartupProcess {
  func run(completion: @escaping (Bool) -> Void) {
    Logger.shared.logLevel = Constants.Environment.isDebug ? .debug : .info
    completion(true)
  }
}
