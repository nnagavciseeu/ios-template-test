//
//  ConnectionServiceObserver.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

public protocol ConnectionServiceObserver {
  func connectionService(
    _ service: ConnectionService,
    connectionChanged connected: Bool,
    connectionType: ConnectionService.ConnectionType
  )
}
