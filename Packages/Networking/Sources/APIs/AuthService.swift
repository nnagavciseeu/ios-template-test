//
//  AuthService.swift
//  template
//
//  Created by Dejan Skledar on 09/10/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import OpenAPI

public class AuthService {
  private let client: OpenAPIClientProtocol
  
  public init(client: OpenAPIClientProtocol = OpenAPIClient()) {
    self.client = client
  }
  
  public func login(username: String, password: String) async throws -> Components.Schemas.AuthResponseDto {
    try await client
      .client
      .AuthController_login(body: .json(.init(email: username, password: password)))
      .ok
      .body
      .json
  }
}

