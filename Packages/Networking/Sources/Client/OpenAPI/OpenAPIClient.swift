//
//  OpenAPIClient.swift
//  template
//
//  Created by Dejan Skledar on 09/10/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Auth
import Foundation
import HTTPTypes
import OpenAPI
import OpenAPIRuntime
import OpenAPIURLSession
import Utils

public struct OpenAPIClient: OpenAPIClientProtocol {
  public var client: APIProtocol
  
  public init() {
    let session: URLSession = {
      let configuration: URLSessionConfiguration = URLSessionConfiguration.default
      configuration.timeoutIntervalForRequest = 10
      configuration.timeoutIntervalForResource = 10
      configuration.waitsForConnectivity = true
      
      return .init(configuration: configuration)
    }()

    client = Client(
      serverURL: .init(string: hostBaseUrl) ?? .defaultOpenAPIServerURL,
      transport: URLSessionTransport(configuration: .init(session: session)),
      middlewares: []
    )
  }
}
