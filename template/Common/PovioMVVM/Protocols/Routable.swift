//
//  Routable.swift
//  template
//
//  Created by Dejan Skledar on 30/07/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

protocol Routable: AnyObject {
  func dismiss(completion: (() -> Void)?)
  func pop()
}

extension Routable where Self: BaseRouter {
  func dismiss(completion: (() -> Void)? = nil) {
    viewController.dismiss(animated: true) {
      completion?()
    }
  }
  
  func pop() {
    navigationController?.popViewController(animated: true)
  }
}
