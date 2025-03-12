//
//  Constants.swift
//  template
//
//  Created by Borut Tomazin on 27/05/2022.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import Foundation

enum Constants {
  enum UI {
    enum Animation {
      static let presentDuration: TimeInterval = 0.3
      static let dismissDuration: TimeInterval = 0.2
    }
  }
  
  enum Configuration {
    enum Sentry {
      static let DNS = "https://***.ingest.sentry.io/***"
    }
  }
  
  enum Environment: String {
    case dev
    case qa
    case staging
    case production
    
#if DEBUG
    static let isDebug = true
#else
    static let isDebug = false
#endif
    
#if PRODUCTION
    static let current = Environment.production
#elseif STAGING
    static let current = Environment.staging
#elseif QA
    static let current = Environment.qa
#else
    static let current = Environment.dev
#endif
  }
  
  enum Platform {
#if targetEnvironment(simulator)
    static let isSimulator = true
#else
    static let isSimulator = false
#endif
  }
}
