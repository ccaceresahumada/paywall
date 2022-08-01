//
//  PaywallViewModel.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

protocol PaywallViewModelDelegate: AnyObject {
    func paywallUpdatedSuccessfully()
    func paywallFailedToUpdate(_ error: Error?)
}

class PaywallViewModel {
    
    // MARK: - Private properties
    
    private let type: PaywallType
    
    // MARK: - Internal properties
    
    var paywall: PaywallLayout?
    weak var delegate: PaywallViewModelDelegate?
    
    // MARK: - Initializer
    
    init(type: PaywallType, delegate: PaywallViewModelDelegate?) {
        self.type = type
        self.delegate = delegate
    }
    
    // MARK: - Internal methods
    
    func getCurrentType() -> PaywallType {
        return type
    }
    
    func getBackgroundImageName() -> String {
        guard let paywall = paywall else { return "" }
        return parseURLForFileName(url: paywall.metadata.backgroundImage)
    }
    
    func getBackgroundColor() -> UIColor? {
        guard let paywall = paywall else { return .clear }
        return UIColor(hex: paywall.metadata.backgroundColor)
    }
    
    func reloadData() {
        Network.shared.fetchPaywall(type) { [weak self] paywall, error in
            guard let paywall = paywall else {
                DispatchQueue.main.sync {
                    self?.delegate?.paywallFailedToUpdate(error)
                }
                return
            }
            DispatchQueue.main.sync {
                self?.paywall = paywall
                self?.delegate?.paywallUpdatedSuccessfully()
            }
        }
    }
    
    // MARK: - Private utils
    
    func parseURLForFileName(url: String) -> String {
        return (NSURLComponents(string: url)?.path as? NSString)?.lastPathComponent ?? ""
    }
}
