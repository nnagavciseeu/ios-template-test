//
//  DefaultAlamofireNetworkClient.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Alamofire
import Auth
import Foundation
import PovioKitNetworking

public final class DefaultAlamofireNetworkClient: AlamofireNetworkClient {
  public init() {
    let session: Session = {
      let configuration: URLSessionConfiguration = .af.default
      configuration.timeoutIntervalForRequest = AlamofireNetworkClient.requestTimeoutInterval
      configuration.timeoutIntervalForResource = AlamofireNetworkClient.requestTimeoutInterval
      configuration.waitsForConnectivity = true
      
      let interceptor = Interceptor(
        retriers: [RetryPolicy()],
        interceptors: []
      )
      
      return Session(configuration: configuration,
                     interceptor: interceptor,
                     eventMonitors: AlamofireNetworkClient.eventMonitors)
    }()
    super.init(session: session, eventMonitors: [ANCSentryErrorMonitor()])
  }
}
