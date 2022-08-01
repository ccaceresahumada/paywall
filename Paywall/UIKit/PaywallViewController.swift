//
//  PaywallViewController.swift
//  Paywall
//
//  Copyright © 2020 Disney Streaming. All rights reserved.
//

import UIKit

class PaywallViewController: UIViewController {

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network.shared.fetchPaywall(.disney) { [weak self] paywall, error in
            self?.networkResponseHandler(paywall: paywall, error: error)
        }
    }
    
    // MARK: - UIResponder
    
    func didShake() {
        Network.shared.fetchPaywall(.espn) { [weak self] paywall, error in
            self?.networkResponseHandler(paywall: paywall, error: error)
        }
    }
    
    // MARK: - Private methods
    
    private func networkResponseHandler(paywall: PaywallLayout?, error: Error?) {
        guard let paywall = paywall else {
            print("Error = \(String(describing: error))")
            return
        }
        
        DispatchQueue.main.sync {
            self.drawPaywall(paywall)
        }
    }
    
    private func drawPaywall(_ paywall: PaywallLayout) {
        print(paywall.metadata.identifier)
    }

}

// MARK: - UIResponder

extension PaywallViewController {

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            didShake()
        }
    }
}
