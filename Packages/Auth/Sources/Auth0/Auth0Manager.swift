//
//  AuthManager.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Auth0
import CommonCrypto
import Foundation
import PovioKitAuthApple
import PovioKitAuthGoogle
import PovioKitAuthCore
import PovioKitCore
import UIKit
import Utils

public final class Auth0Manager {
  public static let shared = Auth0Manager()
  private let socialAuthManager: SocialAuthenticationManager
  internal let keychainHelper: KeychainHelper = .standard
  public private(set) var oauthContainer: OAuthContainer?
  public private(set) var userData: AuthUserData?
  
  private init() {
    socialAuthManager = SocialAuthenticationManager(authenticators: [
      AppleAuthenticator(),
      GoogleAuthenticator()
    ])
    loadContainer()
  }
}

// MARK: - General Public Methods
public extension Auth0Manager {
  @discardableResult
  func refreshAccessToken(with refreshToken: Token) async throws -> OAuthContainer {
    do {
      let credentials = try await Auth0
        .authentication(
          clientId: Auth0App.current.clientId,
          domain: Auth0App.current.domain
        )
        .renew(withRefreshToken: refreshToken, scope: Auth0App.current.scope)
        .start()
      
      let oauthContainer = try credentials.toOAuthContainer()
      try storeContainer(oauthContainer: oauthContainer)
      
      return oauthContainer
    } catch {
      if let authError = error as? AuthenticationError,
         !authError.isNetworkError,
         !authError.isPasswordLeaked {
        throw AuthError.invalidRefreshToken
      }
      throw error
    }
  }
}

// MARK: - Authenticator Methods
extension Auth0Manager: Authenticator {
  public var isAuthenticated: Authenticated {
    oauthContainer != nil && userData != nil
  }
  
  public var currentAuthenticator: Authenticator? {
    socialAuthManager.currentAuthenticator
  }
  
  public func authenticator<A: Authenticator>(for type: A.Type) -> A? {
    socialAuthManager.authenticator(for: type)
  }
  
  public func signOut() {
    socialAuthManager.signOut()
    _ = CredentialsManager(
      authentication: Auth0.authentication(
        clientId: Auth0App.current.clientId,
        domain: Auth0App.current.domain
      )
    ).clear()
    oauthContainer = nil
    userData = nil
    try? keychainHelper.removeAll()
  }
  
  public func canOpenUrl(_ url: URL, application: UIApplication, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
    socialAuthManager.canOpenUrl(url, application: application, options: options)
  }
}

// MARK: - Internal Methods
internal extension Auth0Manager {
  func loadContainer() {
    oauthContainer = keychainHelper.read(type: OAuthContainer.self, from: .authToken)
  }
  
  func storeContainer(oauthContainer: OAuthContainer) throws {
    try keychainHelper.save(oauthContainer, for: .authToken)
  }
  
  func loadUserData() {
    userData = keychainHelper.read(type: AuthUserData.self, from: .authUserData)
  }
  
  func storeUserData(authUserData: AuthUserData) throws {
    try keychainHelper.save(authUserData, for: .authUserData)
    self.userData = authUserData
  }
  
  func generateCodeVerifierAndChallenge() -> (verifier: String, challenge: String) {
    var verifierBuffer = [UInt8](repeating: 0, count: 32)
    _ = SecRandomCopyBytes(kSecRandomDefault, verifierBuffer.count, &verifierBuffer)
    let codeVerifier = Data(verifierBuffer).base64EncodedString()
      .replacingOccurrences(of: "+", with: "-")
      .replacingOccurrences(of: "/", with: "_")
      .replacingOccurrences(of: "=", with: "")
    
    guard let data = codeVerifier.data(using: .utf8) else {
      fatalError("Could not generate code verifier!")
    }
    var challengeBuffer = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
    _ = data.withUnsafeBytes {
      CC_SHA256($0.baseAddress, CC_LONG(data.count), &challengeBuffer)
    }
    let hash = Data(challengeBuffer)
    let codeChallenge = hash.base64EncodedString()
      .replacingOccurrences(of: "+", with: "-")
      .replacingOccurrences(of: "/", with: "_")
      .replacingOccurrences(of: "=", with: "")
    
    return (codeVerifier, codeChallenge)
  }
  
  func handleCredentials(credentials: Credentials, email: String, name: String? = nil) throws {
    let oauthContainer = try credentials.toOAuthContainer()
    try storeContainer(oauthContainer: oauthContainer)
    let authUserData = AuthUserData(
      source: .email,
      email: email,
      name: name
    )
    try storeUserData(authUserData: authUserData)
  }
}
