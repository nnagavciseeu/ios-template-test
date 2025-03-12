//
//  APIErrorMapper.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

enum APIErrorMapper {
  static func transform(_ object: APIErrorDto) -> APIError {
    var validationErrors: [APIError.ValidationError]?
    if let errors = object.details?.errors {
      validationErrors = errors.map { .init(message: $0.message, field: $0.field) }
    }
    return .init(
      type: .init(rawValue: object.code) ?? .unknown,
      message: object.message,
      validationErrors: validationErrors ?? [],
      code: object.errorCode,
      meta: .init(requestId: object.meta.requestId)
    )
  }
}
