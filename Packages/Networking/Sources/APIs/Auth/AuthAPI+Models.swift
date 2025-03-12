//
//  AuthAPI+Models.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import PovioMacro

// MARK: - Requests
public extension AuthAPI {
  @StructInit
  struct SignInRequest: Encodable {
    public let email: String
  }
}

// MARK: - Responses
public extension AuthAPI {
  struct SignInResponse: Decodable {
    public let id: String
  }
}
