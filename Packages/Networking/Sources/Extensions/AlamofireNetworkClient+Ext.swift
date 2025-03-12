//
//  AlamofireNetworkClient+Ext.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Alamofire
import Foundation
import PovioKitNetworking

public extension AlamofireNetworkClient {
  static var requestTimeoutInterval: TimeInterval = 10
  static let eventMonitors: [Alamofire.EventMonitor] = {
#if DEBUG
    return [AlamofireConsoleLogger()]
#else
    return []
#endif
  }()
  
  static var oauth: OAuthAlamofireNetworkClient = {
    OAuthAlamofireNetworkClient()
  }()
  
  static var `default`: DefaultAlamofireNetworkClient = {
    DefaultAlamofireNetworkClient()
  }()
}

public extension AlamofireNetworkClient.DataRequest {
  func defaultFailureHandler(_ decoder: JSONDecoder = .default) -> Self {
    handleFailure { originalError, data in
      do {
        let errorDto = try decoder.decode(APIErrorDto.self, from: data)
        var error = APIErrorMapper.transform(errorDto)
        error.code = originalError.errorCode
        return error
      } catch {
        // we receive empty data on timeout
        let type: APIError.ErrorType = originalError.asAFError?.underlyingError?.errorCode == NSURLErrorTimedOut
        ? .requestTimeout
        : .serializationError
        return APIError(
          type: type,
          message: "Something went wrong 😳!",
          validationErrors: [],
          code: originalError.errorCode, 
          meta: .init(requestId: "/")
        )
      }
    }
  }
}
