//
//  Credentials+Extensions.swift
//  template
//
//  Created by Dejan Skledar on 23/10/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Auth0
import PovioKitAuthCore

extension Credentials {
  func toOAuthContainer() throws -> OAuthContainer {
    guard let refreshToken = refreshToken else {
      throw AuthError.missingRefreshToken
    }
    
    let jwtDecoder = try JWTDecoder(token: accessToken)
    return .init(
      idToken: idToken,
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: jwtDecoder.expiresAt
    )
  }
}
