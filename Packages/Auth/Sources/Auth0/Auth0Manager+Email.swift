//
//  AuthManager+Email.swift
//  template
//
//  Created by Dejan Skledar on 23/10/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import Auth0
import PovioKitAuthCore
import PovioKitCore
import Utils

// MARK: - Public Email Methods
public extension Auth0Manager {
  func login(with email: String, password: String) async throws -> OAuthContainer {
    let auth = Auth0
      .authentication(
        clientId: Auth0App.current.clientId,
        domain: Auth0App.current.domain
      )
    
    do {
      let credentials = try await auth
        .login(
          usernameOrEmail: email,
          password: password,
          realmOrConnection: Auth0App.current.realm,
          audience: Auth0App.current.audience,
          scope: Auth0App.current.scope
        )
        .start()
      
      let oauthContainer = try credentials.toOAuthContainer()
      try storeContainer(oauthContainer: oauthContainer)
      let authUserData = AuthUserData(
        source: .email,
        email: email
      )
      try storeUserData(authUserData: authUserData)
      return oauthContainer
    } catch let auth0Error as Auth0.AuthenticationError {
      if auth0Error.isInvalidCredentials || auth0Error.isPasswordNotStrongEnough {
        throw AuthError.invalidCredentials
      }
      throw auth0Error
    } catch {
      throw error
    }
  }
  
  func registerAndLogin(email: String, password: String) async throws -> OAuthContainer {
    let auth = Auth0
      .authentication(
        clientId: Auth0App.current.clientId,
        domain: Auth0App.current.domain
      )
    
    // signup
    do {
      _ = try await auth
        .signup(
          email: email,
          username: nil,
          password: password,
          connection: Auth0App.current.realm
        )
        .start()
    } catch {
      PovioKitCore.Logger.error("Failed to signUp user! \(error.localizedDescription)")
    }
    
    // login
    let credentials = try await auth
      .login(
        usernameOrEmail: email,
        password: password,
        realmOrConnection: Auth0App.current.realm,
        audience: Auth0App.current.audience,
        scope: Auth0App.current.scope
      )
      .start()
    
    let oauthContainer = try credentials.toOAuthContainer()
    try storeContainer(oauthContainer: oauthContainer)
    let authUserData = AuthUserData(
      source: .email,
      email: email
    )
    try storeUserData(authUserData: authUserData)
    return oauthContainer
  }
  
  func resetPassword(email: String) async throws {
    try await Auth0
      .authentication(
        clientId: Auth0App.current.clientId,
        domain: Auth0App.current.domain
      )
      .resetPassword(
        email: email,
        connection: Auth0App.current.realm
      )
      .start()
  }
}
