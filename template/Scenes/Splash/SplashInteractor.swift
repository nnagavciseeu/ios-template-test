//
//  SplashInteractor.swift
//  template
//
//  Created by Dejan Skledar on 30/08/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

protocol SplashInteractableLogic: AnyObject {
  var dataLoaded: () -> Void { get }
}

class SplashInteractor {
  private let input: SplashScene.Input
  
  init(input: SplashScene.Input) {
    self.input = input
  }
}

// MARK: - Getters
extension SplashInteractor {
  var dataLoaded: () -> Void {
    input.dataLoaded
  }
}

// MARK: - Splash Interactable
extension SplashInteractor: SplashInteractableLogic { /* -- */ }

// MARK: - Private Helpers
private extension SplashInteractor { /* -- */ }
