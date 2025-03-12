//
//  SplashRouter.swift
//  template
//
//  Created by Dejan Skledar on 30/08/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import SwiftUI
import UIKit

protocol SplashRoutingLogic: Routable { /* -- */ }

final class SplashRouter: BaseRouter {
  init(input: SplashScene.Input) {
    let viewController = CustomHostingController<SplashView>()
    super.init(viewController: viewController)
    
    let interactor = SplashInteractor(input: input)
    viewController.rootView = .init(viewModel: .init(router: self, interactor: interactor))
  }
}

// MARK: - Routing Logic
extension SplashRouter: SplashRoutingLogic { /* -- */ }

@available(iOS 17.0, *)
#Preview {
  let router = SplashRouter(input: .init {})
  return BaseNavigationController(router: router)
}
