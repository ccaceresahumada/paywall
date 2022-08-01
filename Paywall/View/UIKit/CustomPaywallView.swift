//
//  CustomPaywallView.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

class CustomPaywallView: UIView {
    
    // MARK: - Internal properties
    
    var viewModel: PaywallViewModel? {
        didSet {
            layout()
        }
    }

    // MARK: - Layout components
    
    private func layout() {
        backgroundColor = .orange
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEST"
        addSubview(label)
    }
}
