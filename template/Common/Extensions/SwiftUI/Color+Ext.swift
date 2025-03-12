//
//  Color+Ext.swift
//  template
//
//  Created by Borut Tomazin on 14/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import SwiftUI

extension Color {
  enum Template {
    static let primary = Color(red: 228, green: 231, blue: 236)
    // Define all colors here...
  }
  
  var uiColor: UIColor {
    UIColor(self)
  }
}
