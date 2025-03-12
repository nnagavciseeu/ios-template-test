//
//  JSONDecoder+Ext.swift
//  template
//
//  Created by Borut Tomazin on 27/05/2022.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

extension JSONDecoder {
  static var `default`: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }
}
