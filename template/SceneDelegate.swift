//
//  SceneDelegate.swift
//  template
//
//  Created by Dejan Skledar on 26/03/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import PovioKitCore
import UIKit

class SceneDelegate: UIResponder {
  /// Returns the first active UIScene. If you are working with multi-scene apps, you need to update this property to your needs
  static var shared: SceneDelegate? {
    UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
  }

  var deepLinkHandlers: [DeepLinkHandling] = []
  
  /// The active Flow Controller, handling Root Navigation
  var flowController: FlowController?
}

// MARK: - UISceneDelegate
extension SceneDelegate: UIWindowSceneDelegate {
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    StartupProcessService()
      .execute(process: LoggerStartupProcess())
      .execute(process: ConnectionServiceStartupProcess())
      .execute(process: SentryStartupProcess())
      .execute(process: FlowControllerStartupProcess(scene: scene) {
        self.flowController = $0
      })
      .execute(process: DeeplinkHandlingStartupProcess(connectionOptions: connectionOptions, flowController: flowController) {
        self.deepLinkHandlers = $0
      })
  }
  
  func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
    deepLinkHandlers.handle(continue: userActivity)
  }
}