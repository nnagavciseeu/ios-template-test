//
//  SplashViewModel.swift
//  template
//
//  Created by Dejan Skledar on 30/08/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import SwiftUI

protocol SplashViewableModelLogic: AnyObject, ObservableObject { /* -- */ }

final class SplashViewModel: ObservableObject {
  private let router: SplashRoutingLogic
  private let interactor: SplashInteractableLogic
  
  init(router: SplashRoutingLogic, interactor: SplashInteractableLogic) {
    self.router = router
    self.interactor = interactor
  }
}

// MARK: - Actions
extension SplashViewModel { /* -- */ }

// MARK: - Public Methods
extension SplashViewModel {
  func preloadData() {
    // Load any data here
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      // Notify the Interator that data is loaded here
      self?.interactor.dataLoaded()
    }
  }
}

// MARK: - Private Helpers
private extension SplashViewModel { /* -- */ }
