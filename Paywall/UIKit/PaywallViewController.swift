//
//  PaywallViewController.swift
//  Paywall
//
//  Copyright © 2020 Disney Streaming. All rights reserved.
//

import UIKit

class PaywallViewController: UIViewController {

  func didShake() {
    // TODO: Reload the paywall whenever the shake gesture occurs
  }

}

extension PaywallViewController {
  override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
    if motion == .motionShake {
      didShake()
    }
  }
}
