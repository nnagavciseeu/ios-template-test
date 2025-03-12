//
//  KeychainHelper.swift
//  template
//
//  Created by Borut Tomazin on 13/05/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation
import KeychainAccess

public final class KeychainHelper {
  private static let userService = "template"
  private static let permanentService = "permanent"
  private let userKeychain: Keychain
  private let permanentKeychain: Keychain
  
  public static let standard = KeychainHelper()
  
  init(userKeychain: Keychain = Keychain(service: userService),
       appleKeychain: Keychain = Keychain(service: permanentService)) {
    self.userKeychain = userKeychain
    self.permanentKeychain = appleKeychain
  }
}

public extension KeychainHelper {
  func save(_ value: String?, for key: Key, type: KeychainType = .user) {
    switch type {
    case .user:
      userKeychain[key.value] = value
    case .permanent:
      permanentKeychain[key.value] = value
    }
  }
  
  func read(from key: Key, type: KeychainType = .user) -> String? {
    switch type {
    case .user:
      return userKeychain[key.value]
    case .permanent:
      return permanentKeychain[key.value]
    }
  }
  
  func save<T>(_ item: T, for key: Key) throws where T: Codable {
    let data = try JSONEncoder().encode(item)
    try userKeychain.set(data, key: key.value)
  }
  
  func read<T>(type: T.Type, from key: Key) -> T? where T: Codable {
    guard let data = try? userKeychain.getData(key.value) else { return nil }
    do {
      let item = try JSONDecoder().decode(type, from: data)
      return item
    } catch {
      return nil
    }
  }
  
  func removeAll() throws {
    try userKeychain.removeAll()
  }
}

public extension KeychainHelper {
  enum KeychainType {
    case user
    case permanent
  }
}

public extension KeychainHelper {
  enum Key {
    case custom(value: String)
    case authToken
    case pushToken
    case authUserData
    
    var value: String {
      switch self {
      case .custom(let value):
        return value
      case .authToken:
        return "AuthToken"
      case .pushToken:
        return "PushToken"
      case .authUserData:
        return "AuthUserData"
      }
    }
  }
}