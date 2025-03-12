//
//  APIErrorDto.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

struct APIErrorDto: Decodable, Error {
  let code: String
  let message: String
  let details: Details?
  let meta: Meta
}

extension APIErrorDto {
  struct Details: Decodable {
    let errors: [ValidationError]
  }
  
  struct ValidationError: Decodable {
    let message: String
    let field: String
  }
  
  struct Meta: Decodable {
    let requestId: String
  }
}
