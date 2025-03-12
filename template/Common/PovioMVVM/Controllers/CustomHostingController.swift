//
//  CustomHostingController.swift
//  template
//
//  Created by Dejan Skledar on 26/03/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

#if canImport(SnapKit)
import SnapKit
#endif
import SwiftUI
import UIKit

struct NavigationBarConfig {
  var isHidden: Bool = false
  var tintColor: UIColor = .black
  var backgroundColor: UIColor = .white
}

final class CustomHostingController<RootView: View>: UIViewController {
  private let navigationBarConfig: NavigationBarConfig
  private let hostingControllerBackgroundColor: UIColor

  // swiftlint:disable:next implicitly_unwrapped_optional
  var rootView: RootView!
  
  init(
    navigationBarConfig: NavigationBarConfig = .init(),
    hostingControllerBackgroundColor: UIColor = .white
  ) {
    self.navigationBarConfig = navigationBarConfig
    self.hostingControllerBackgroundColor = hostingControllerBackgroundColor
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let hostingController = UIHostingController(rootView: rootView)
    view.addSubview(hostingController.view)
    addChild(hostingController)
    
    setupViewConstraints(for: hostingController)

    hostingController.didMove(toParent: self)
    hostingController.view.backgroundColor = hostingControllerBackgroundColor
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(navigationBarConfig.isHidden, animated: animated)
    
    if let navigationController = navigationController as? BaseNavigationController {
      navigationController.navigationBarBackgroundColor = navigationBarConfig.backgroundColor
      navigationController.navigationBarTintColor = navigationBarConfig.tintColor
    }
  }
  
  private func setupViewConstraints(for hostingController: UIViewController) {
    #if canImport(SnapKit)
    hostingController.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    #else
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    #endif
  }
}

// MARK: - HostingNavigationConfigurable
extension CustomHostingController: HostingNavigationConfigurable {
  var shouldHideNavigationBar: Bool { navigationBarConfig.isHidden }
}
