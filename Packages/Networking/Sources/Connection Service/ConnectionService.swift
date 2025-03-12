//
//  ConnectionService.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import PovioKitCore
import Reachability

/// Class for observing internet connection status
public final class ConnectionService {
  public static let shared = ConnectionService()
  private let reachability: Reachability?
  private lazy var broadcast = Broadcast<ConnectionServiceObserver>()
  public private(set) var isConnected: Bool = false {
    didSet {
      guard oldValue != isConnected else { return }
      onConnectionChange()
    }
  }
  
  private init() {
    do {
      reachability = try? Reachability()
      
      // online notifier
      reachability?.whenReachable = { [weak self] reachability in
        switch reachability.connection {
        case .wifi, .cellular:
          self?.isConnected = true
        case .unavailable:
          self?.isConnected = false
        }
      }
      
      // offline notifier
      reachability?.whenUnreachable = { [weak self] _ in
        self?.isConnected = false
      }
      
      try reachability?.startNotifier()
    } catch {
      Logger.error("Cannot start Reachability service")
    }
  }
  
  deinit {
    reachability?.stopNotifier()
  }
}

// MARK: - Public Methods
public extension ConnectionService {
  enum ConnectionType: String {
    case cellular = "Cellular"
    case wifi = "WiFi"
    case unknown = "No connection"
  }
  
  var connectionType: ConnectionType {
    guard let connection = reachability?.connection else { return .unknown }
    switch connection {
    case .wifi:
      return .wifi
    case .cellular:
      return .cellular
    case .unavailable:
      return .unknown
    }
  }
  
  func addObserver(_ observer: ConnectionServiceObserver) {
    broadcast.add(observer: observer)
  }
}

// MARK: - Private Methods
private extension ConnectionService {
  func onConnectionChange() {
    Logger.info("Connection status changed", params: ["connection": connectionType.rawValue])
    broadcast.invoke(on: .main) { [weak self] observer in
      guard let self else { return }
      observer.connectionService(self, connectionChanged: isConnected, connectionType: connectionType)
    }
  }
}
