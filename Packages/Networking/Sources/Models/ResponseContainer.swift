//
//  ResponseContainer.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

struct ResponseContainer<D: Decodable>: Decodable {
  let data: D
}
