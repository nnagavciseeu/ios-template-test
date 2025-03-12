//
//  OAuthAlamofireNetworkClient.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Alamofire
import Auth
import Foundation
import PovioKitNetworking

public final class OAuthAlamofireNetworkClient: AlamofireNetworkClient {
  private let authenticationInterceptor: AuthenticationInterceptor<AlamofireAuth0Authenticator>
  
  public init() {
    let interceptor = AuthenticationInterceptor(authenticator: AlamofireAuth0Authenticator())
    let session: Session = {
      let configuration: URLSessionConfiguration = .af.default
      configuration.timeoutIntervalForRequest = AlamofireNetworkClient.requestTimeoutInterval
      configuration.timeoutIntervalForResource = AlamofireNetworkClient.requestTimeoutInterval
      configuration.waitsForConnectivity = true
      
      let interceptor = Interceptor(retriers: [RetryPolicy()],
                                    interceptors: [interceptor])
      
      return Session(configuration: configuration,
                     interceptor: interceptor,
                     eventMonitors: AlamofireNetworkClient.eventMonitors)
    }()
    self.authenticationInterceptor = interceptor
    super.init(session: session, eventMonitors: [ANCSentryErrorMonitor()])
  }
  
  public func updateOAuthContainer(_ container: OAuthContainer?) {
    authenticationInterceptor.credential = container
  }
}
