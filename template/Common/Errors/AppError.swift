//
//  AppError.swift
//  template
//
//  Created by Borut Tomazin on 14/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import Networking

enum AppError: Error {
  case general
  case custom(String)
  case api(error: Error)
  case nilValue
}

extension AppError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .general, .nilValue:
      return "Something went wrong. Please try again."
    case .custom(let description):
      return description
    case .api(let error):
      switch error.apiError {
      case .some(let apiError):
        return apiError.message
      default:
        return error.localizedDescription
      }
    }
  }
}
