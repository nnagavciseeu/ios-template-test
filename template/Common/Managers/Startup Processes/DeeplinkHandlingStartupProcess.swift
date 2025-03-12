//
//  FlowControllerStartupProcess.swift
//  template
//
//  Created by Dejan Skledar on 31/12/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import PovioKitCore
import UIKit

struct DeeplinkHandlingStartupProcess: StartupProcess {
  private let completion: ([DeepLinkHandling]) -> Void
  private let flowController: FlowController?
  private let connectionOptions: UIScene.ConnectionOptions
  
  init(connectionOptions: UIScene.ConnectionOptions, flowController: FlowController?, completion: @escaping ([DeepLinkHandling]) -> Void) {
    self.connectionOptions = connectionOptions
    self.flowController = flowController
    self.completion = completion
  }
  
  func run(completion: @escaping (Bool) -> Void) {
    guard let flowController else {
      fatalError("FlowController is nil while initializing DeeplinkHandlingStartupProcess")
    }
    let deepLinkHandlers: [DeepLinkHandling] = [
      DefaultDeeplinkHandler(flowController: flowController)
    ]

    if let userActivity = connectionOptions.userActivities.first {
      deepLinkHandlers.handle(continue: userActivity)
    }
    
    self.completion(deepLinkHandlers)
    completion(true)
  }
}
