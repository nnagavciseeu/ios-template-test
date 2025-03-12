//
//  Encodable+Ext.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

extension Encodable {
  func toDictionary() -> [String: Any]? {
    guard let data = try? self.encoded() else { return nil }
    guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
    else { return nil }
    return dictionary
  }
  
  func encoded() throws -> Data {
    try JSONEncoder.default.encode(self)
  }
}
