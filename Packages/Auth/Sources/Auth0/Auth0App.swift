//
//  Auth0App.swift
//  template
//
//  Created by Dejan Skledar on 23/10/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

public enum Auth0App {
  case dev
  case sta
  case prod
}

public extension Auth0App {
  static var current: Auth0App = .dev
}

extension Auth0App {
  var clientId: String {
    switch self {
    case .dev:
      return "TODO"
    case .sta:
      return "TODO"
    case .prod:
      return "TODO"
    }
  }
  
  var clientSecret: String {
    switch self {
    case .dev:
      return "TODO"
    case .sta:
      return "TODO"
    case .prod:
      return "TODO"
    }
  }
  
  var domain: String {
    switch self {
    case .dev:
      return "TODO"
    case .sta:
      return "TODO"
    case .prod:
      return "TODO"
    }
  }
  
  var scope: String {
    "openid email profile offline_access"
  }
  
  public var redirectUrl: URL {
    switch self {
    case .dev:
      return "TODO"
    case .sta:
      return "TODO"
    case .prod:
      return "TODO"
    }
  }
  
  public var audience: String {
    switch self {
    case .dev:
      return "backend-api-dev"
    case .sta:
      return "backend-api-staging"
    case .prod:
      return "backend-api-prod"
    }
  }
  
  public var realm: String {
    switch self {
    case .dev, .sta, .prod:
      return "Username-Password-Authentication"
    }
  }
}
