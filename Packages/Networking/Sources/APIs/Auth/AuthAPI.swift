//
//  AuthAPI.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import PovioKitNetworking

public final class AuthAPI {
  private let client: AlamofireNetworkClient
  
  public init(client: AlamofireNetworkClient = .default) {
    self.client = client
  }
}

public extension AuthAPI {
  func signIn(with request: SignInRequest) async throws -> SignInResponse {
    try await client
      .request(
        method: .get,
        endpoint: Endpoints.signIn
      )
      .validate()
      .defaultFailureHandler()
      .decode(ResponseContainer<SignInResponse>.self, decoder: .default)
      .data
  }
}
