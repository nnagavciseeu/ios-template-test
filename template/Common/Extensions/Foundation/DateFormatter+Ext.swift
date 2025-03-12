//
//  DateFormatter+Ext.swift
//  template
//
//  Created by Borut Tomazin on 14/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

extension DateFormatter {
  /// `Feb 1, 2024`
  static let dayMonthYear: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .autoupdatingCurrent
    dateFormatter.dateFormat = "MMM d, y"
    return dateFormatter
  }()
}
