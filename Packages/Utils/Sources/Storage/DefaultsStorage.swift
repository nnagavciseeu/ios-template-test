//
//  DefaultsStorage.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import PovioKitCore

public final class DefaultsStorage {
  public init() { /* not default impl */ }
  
  @UserDefault(defaultValue: false, key: Key.isStorageInitialized.value)
  public var isStorageInitialized: Bool
  
  // add other defaults here ...
  
  public func clear() {
    // we should not clear all userDefaults, some services like "SignIn with LinkedIn" depends on it
    Key.allCases.forEach {
      UserDefaults.standard.removeObject(forKey: $0.value)
    }
  }
  
  public func clear(suiteName: String) {
    UserDefaults.standard.removePersistentDomain(forName: suiteName)
  }
}

// MARK: - Private Methods
private extension DefaultsStorage {
  enum Key: CaseIterable {
    case isStorageInitialized
    
    var value: String {
      let key: String
      switch self {
      case .isStorageInitialized:
        key = "generic.isStorageInitialized"
      }
      
      return "com.template.\(key)"
    }
  }
}
