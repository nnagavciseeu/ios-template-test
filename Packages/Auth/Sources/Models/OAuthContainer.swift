//
//  OAuthContainer.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Alamofire
import Foundation

public typealias Token = String

public struct OAuthContainer: Codable, AuthenticationCredential {
  public let idToken: Token
  public let accessToken: Token
  public let refreshToken: Token
  public let expiresAt: Date?
  
  public var requiresRefresh: Bool {
    guard let expirationDate = expiresAt else { return true }
    return expirationDate.timeIntervalSince(Date()) < 0
  }
}
