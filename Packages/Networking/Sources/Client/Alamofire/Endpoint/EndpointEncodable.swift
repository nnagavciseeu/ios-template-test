//
//  EndpointEncodable.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import PovioKitNetworking
import Utils

protocol EndpointEncodable: URLConvertible {
  typealias Path = String
  
  var path: Path { get }
  var url: String { get }
}

extension EndpointEncodable {
  var url: String {
    "\(Configuration.hostBaseUrl)/mobile/\(Version.v1.rawValue)/\(path)"
  }
  
  func asURL() throws -> URL {
    .init(stringLiteral: url)
  }
}

extension EndpointEncodable where Self: RawRepresentable, Self.RawValue == String {
  var path: String {
    rawValue
  }
}
