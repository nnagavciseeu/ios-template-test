//
//  OpenAPIClientProtocol.swift
//  template
//
//  Created by Dejan Skledar on 09/10/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import OpenAPI
import OpenAPIRuntime
import OpenAPIURLSession

public protocol OpenAPIClientProtocol {
  var client: APIProtocol { get }
}
