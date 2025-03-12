//
//  JSONDecoder+Ext.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

public extension JSONEncoder {
  static var `default`: JSONEncoder {
    let encoder = JSONEncoder()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    encoder.dateEncodingStrategy = .formatted(dateFormatter)
    return encoder
  }
}
