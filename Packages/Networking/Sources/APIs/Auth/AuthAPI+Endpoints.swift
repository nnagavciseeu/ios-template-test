//
//  AuthAPI+Endpoints.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import PovioMacro

extension AuthAPI {
  enum Endpoints: EndpointEncodable {
    case signIn
    
    var path: Path {
      switch self {
      case .signIn:
        return "signin-endpoint"
      }
    }
  }
}
