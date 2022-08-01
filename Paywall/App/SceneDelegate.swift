//
//  SceneDelegate.swift
//  Paywall
//
//  Copyright © 2020 Disney Streaming. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  /// `true` to use UIKit, `false` to use SwiftUI.
  let useUIKit = true

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }

    let window = UIWindow(windowScene: windowScene)
    if useUIKit {
      let rootViewController = PaywallViewController()
      rootViewController.view.backgroundColor = .red
      window.rootViewController = rootViewController
    }
    else {
      let rootView = PaywallView()
      window.rootViewController = UIHostingController(rootView: rootView)
    }
    self.window = window
    window.makeKeyAndVisible()
  }

}

