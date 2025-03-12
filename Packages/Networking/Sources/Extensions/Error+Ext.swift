//
//  Error+Ext.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import PovioKitNetworking

public extension Error {
  var apiError: APIError? {
    guard let error = self as? AlamofireNetworkClient.Error else { return self as? APIError }
    switch error {
    case .other(let error, _):
      return error as? APIError
    default:
      return nil
    }
  }
  
  var errorCode: Int {
    asAFError?.responseCode ?? (self as NSError).code
  }
}
