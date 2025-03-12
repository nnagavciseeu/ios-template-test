//
//  ANCSentryErrorMonitor.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import PovioKitNetworking
import Sentry

final class ANCSentryErrorMonitor: RequestMonitor {
  func requestDidFail(_ request: AlamofireNetworkClient.DataRequest, with error: AlamofireNetworkClient.Error) {
    var domain: String
    var requestId: String?
    var additionalInfo: String?
    if case let .other(swiftError, info) = error, let decodingError = swiftError.asAFError, decodingError.isResponseSerializationError {
      domain = "API_SERIALIZATION"
      requestId = getRequestId(from: info)
      additionalInfo = decodingError.underlyingError.debugDescription
    } else if case let .other(swiftError, _) = error, let apiError = swiftError as? APIError {
      domain = apiError.type.rawValue
      requestId = apiError.meta.requestId
    } else if case let .request(_, info) = error {
      domain = "API_REQUEST"
      requestId = getRequestId(from: info)
    } else {
      domain = "API_REQUEST"
    }
    
    let errorInfo = error.info
    let errorCode = errorInfo.responseHTTPCode ?? 0
    let requestInfo = SentryError(
      httpCode: errorCode,
      method: errorInfo.method?.rawValue,
      endpoint: (try? errorInfo.endpoint?.asURL())?.absoluteString,
      body: errorInfo.body.flatMap { String(data: $0, encoding: .utf8) },
      response: errorInfo.response.flatMap { String(data: $0, encoding: .utf8) }, 
      requestId: requestId,
      additionalInfo: additionalInfo
    )
    
    let userInfo: Parameters? = requestInfo.toDictionary()
    let recordError = NSError(domain: domain, code: errorCode, userInfo: userInfo)
    SentrySDK.capture(error: recordError)
  }
}

private extension ANCSentryErrorMonitor {
  func getRequestId(from info: AlamofireNetworkClient.Error.ErrorInfo) -> String? {
    guard let data = info.response else { return nil }
    let decoder: JSONDecoder = .default
    return try? decoder.decode(APIErrorDto.self, from: data).meta.requestId
  }
}
