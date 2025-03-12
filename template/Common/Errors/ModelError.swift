//
//  ModelError.swift
//  template
//
//  Created by Borut Tomazin on 14/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

enum ModelError: Error {
  case mapping
  case noCohortFound
}

extension ModelError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .mapping:
      return "Model mapping failed!"
    case .noCohortFound:
      return "No cohort found!"
    }
  }
}
