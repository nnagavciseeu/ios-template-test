//
//  AuthUserData.swift
//  template
//
//  Created by Dejan Skledar on 23/10/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

public struct AuthUserData: Codable {
  public let source: Source
  public let email: String
  // Only for Social Login
  public var name: String?
}

public extension AuthUserData {
  enum Source: Codable {
    case email
    case apple
    case linkedIn
  }
}
