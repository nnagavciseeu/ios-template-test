//
//  SentryError.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

struct SentryError: Encodable {
  let httpCode: Int?
  let method: String?
  let endpoint: String?
  let body: String?
  let response: String?
  let requestId: String?
  let additionalInfo: String?
}
