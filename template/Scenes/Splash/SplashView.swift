//
//  SplashView.swift
//  template
//
//  Created by Dejan Skledar on 30/08/2024.
//  Copyright © 2024 Povio Inc. All rights reserved.
//

import SwiftUI

struct SplashView: View {
  @ObservedObject var viewModel: SplashViewModel

  var body: some View {
    Color.white
      .overlay {
        Text("Splash")
      }
      .edgesIgnoringSafeArea(.all)
      .onAppear { viewModel.preloadData() }
  }
}

// MARK: - Helper Methods
extension SplashView { /* -- */ }

// MARK: - Private ViewBuilders
private extension SplashView { /* -- */ }

#Preview {
  SplashView(
    viewModel: SplashViewModel(
      router: SplashRouter(
        input: .init {}
      ),
      interactor: SplashInteractor(
        input: .init {}
      )
    )
  )
}
