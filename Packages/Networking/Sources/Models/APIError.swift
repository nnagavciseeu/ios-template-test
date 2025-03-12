//
//  APIError.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

public struct APIError: Error {
  public let type: ErrorType
  public let message: String
  public let validationErrors: [ValidationError]
  public var code: Int
  public let meta: Meta
  
  public init(type: ErrorType, message: String, validationErrors: [ValidationError], code: Int, meta: Meta) {
    self.type = type
    self.message = message
    self.validationErrors = validationErrors
    self.code = code
    self.meta = meta
  }
}

// MARK: - Public Methods
public extension APIError {
  enum ErrorType: String {
    case unknown = "ERR_UNKNOWN"
    case noConnection = "ERR_APP_NO_CONNECTION"
    case requestTimeout = "ERR_API_REQUEST_TIMEOUT"
    case serializationError = "ERR_APP_SERIALIZATION"
    case inputValidation = "INPUT_VALIDATION_EXCEPTION"
  }
  
  struct ValidationError {
    let message: String
    let field: String
  }
  
  struct Meta {
    let requestId: String
  }
}
