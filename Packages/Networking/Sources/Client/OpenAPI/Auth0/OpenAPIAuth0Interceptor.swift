//
//  OpenAPIAuth0Interceptor.swift
//  template
//
//  Created by Dejan Skledar on 09/10/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import OpenAPI
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes
@preconcurrency import Auth

struct OpenAPIAuth0Interceptor: ClientMiddleware {
  private let authManager: Auth0Manager
  
  init(authManager: Auth0Manager = .shared) {
    self.authManager = authManager
  }
  
  func intercept(
    _ request: HTTPRequest,
    body: HTTPBody?,
    baseURL: URL,
    operationID: String,
    next: @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
  ) async throws -> (HTTPResponse, HTTPBody?) {
    guard let container = authManager.oauthContainer else {
      return try await next(request, body, baseURL)
    }
    
    var request = request
    request.headerFields[.authorization] = "Bearer \(container.accessToken)"
    
    let response = try await next(request, body, baseURL)
    guard response.0.status == .unauthorized else { return response }
    
    do {
      try await authManager.refreshAccessToken(with: container.refreshToken)
    } catch let error {
      if let authError = error as? AuthError, authError == .invalidRefreshToken {
        // If refresh token is invalid, logout user
        NotificationCenter.default.post(name: Constants.logoutUserNotification, object: nil)
        return response
      }
    }
    
    return try await next(request, body, baseURL)
  }
}
