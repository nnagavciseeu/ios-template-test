//
//  Auth0Manager+Apple.swift
//  template
//
//  Created by Dejan Skledar on 24/10/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import UIKit
import Auth0
import PovioKitAuthCore
import PovioKitAuthApple
import PovioKitCore
import Utils

// MARK: - Public Apple Methods
public extension Auth0Manager {
  func authorizeWithAppleCredentials() async throws -> OAuthContainer {
    guard let auth = authenticator(for: AppleAuthenticator.self) else { throw AuthError.failedToStore }

    let authResponse = try await auth.signIn(from: .init())
    let name = (try? name(from: authResponse)) ?? ""
    
    let credentials = try await Auth0
      .authentication(
        clientId: Auth0App.current.clientId,
        domain: Auth0App.current.domain
      )
      .login(
        appleAuthorizationCode: authResponse.authCode,
        fullName: authResponse.nameComponents,
        profile: ["email": authResponse.email.address],
        audience: Auth0App.current.audience,
        scope: Auth0App.current.scope
      )
      .start()
    
    let oauthContainer = try credentials.toOAuthContainer()
    try storeContainer(oauthContainer: oauthContainer)
    let authUserData = AuthUserData(
      source: .apple,
      email: authResponse.email.address,
      name: name
    )
    try storeUserData(authUserData: authUserData)
    
    PovioKitCore.Logger.info("User authorized with Apple successfully.")
    return oauthContainer
  }

  /// Apple returns the name only on the very first signup, after that it's empty string
  /// If signup fails or user re-signups after deleting account we don't get the name anymore
  /// As a fallback name is saved into keychain for future use
  private func name(from authResponse: AppleAuthenticator.Response) throws -> String {
    var name = authResponse.name ?? ""
    
    if !name.isEmpty {
      keychainHelper.save(
        name,
        for: .custom(value: authResponse.email.address),
        type: .permanent
      )
    } else {
      name = keychainHelper.read(
        from: .custom(value: authResponse.email.address),
        type: .permanent
      ) ?? ""
    }
    
    guard !name.isEmpty else {
      throw AuthError.missingName
    }
    
    return name
  }
}
