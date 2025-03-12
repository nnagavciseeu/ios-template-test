//
//  AlamofireAuth0Authenticator.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Alamofire
@preconcurrency import Auth
import Foundation
import PovioKitAuthCore
import PovioKitCore
import PovioKitNetworking

final class AlamofireAuth0Authenticator: Alamofire.Authenticator {
  typealias Credential = OAuthContainer
  private let authManager: Auth0Manager
  
  init(authManager: Auth0Manager = .shared) {
    self.authManager = authManager
  }
  
  func apply(_ credential: OAuthContainer, to urlRequest: inout URLRequest) {
    urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
  }
  
  func refresh(
    _ credential: OAuthContainer,
    for session: Session,
    completion: @escaping (Result<OAuthContainer, Error>) -> Void
  ) {
    Logger.debug("Refreshing access token")
    
    Task { @MainActor in
      do {
         let newCredentials = try await authManager.refreshAccessToken(with: credential.refreshToken)
         Logger.debug("Access token refreshed successfully.")
         AlamofireNetworkClient.oauth.updateOAuthContainer(newCredentials)
         completion(.success(newCredentials))
      } catch {
        Logger.debug("Access token refresh failed!", params: ["error": error.localizedDescription])
        completion(.failure(error))
        if let authError = error as? Auth.AuthError, authError == .invalidRefreshToken {
          NotificationCenter.default.post(name: Constants.logoutUserNotification, object: nil)
        }
      }
    }
  }
  
  func didRequest(
    _ urlRequest: URLRequest,
    with response: HTTPURLResponse,
    failDueToAuthenticationError error: Error
  ) -> Bool {
    false
  }
  
  func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: OAuthContainer) -> Bool {
    true
  }
}
