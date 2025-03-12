//
//  ConnectionServiceStartupProcess.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Networking
import PovioKitCore

final class ConnectionServiceStartupProcess: StartupProcess {
  func run(completion: @escaping (Bool) -> Void) {
    defer { completion(true) }
    _ = ConnectionService.shared
  }
}
