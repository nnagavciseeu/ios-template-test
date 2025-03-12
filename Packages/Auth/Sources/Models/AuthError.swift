//
//  AuthError.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

public enum AuthError: Swift.Error {
  case failedToStore
  case missingRefreshToken
  case missingOauthContainer
  case missingEmail
  case missingName
  case invalidIdToken
  case invalidRefreshToken
  case invalidCredentials
}
