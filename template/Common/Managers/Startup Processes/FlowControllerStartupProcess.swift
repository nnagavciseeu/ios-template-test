//
//  FlowControllerStartupProcess.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import PovioKitCore
import UIKit

final class FlowControllerStartupProcess: StartupProcess {
  private let completion: (FlowController) -> Void
  private let scene: UIScene
  
  init(scene: UIScene, completion: @escaping (FlowController) -> Void) {
    self.scene = scene
    self.completion = completion
  }
  
  func run(completion: @escaping (Bool) -> Void) {
    guard let windowScene = scene as? UIWindowScene else { fatalError("Expected UIWindowScene, instead got \(scene)") }
    let window = UIWindow(windowScene: windowScene)
    let flowController = FlowController(window: window)
    self.completion(flowController)
    flowController.startAppFlow()
    completion(true)
  }
}
