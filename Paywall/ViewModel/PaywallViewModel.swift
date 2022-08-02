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

enum ActionCode: String {
    case loginButtonTapped
    case disneyStartFreeTrialButtonTapped = "dplus_free_trial"
    case espnSignUpNowButtonTapped = "eplus_free_trial"
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
    
    func getComponentWidthPercentage(index: Int) -> CGFloat {
        guard let data = paywall?.components[index] else { return 0 }
        return data.widthPercentage
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
    
    func getComponentConstraints(index: Int) -> ComponentConstraint {
        guard let data = paywall?.components[index] else { return ComponentConstraint() }
        return data.constraints
    }
    
    // MARK: - Button
    
    func getButtonTitle(index: Int) -> String {
        guard let data = paywall?.components[index] as? ButtonComponent else { return "" }
        return data.title
    }
    
    func getButtonTextAlignment(index: Int) -> NSTextAlignment {
        guard let data = paywall?.components[index] as? ButtonComponent else { return .center }
        switch data.titleAlignment {
        case .center:
            return .center
        }
    }
    
    func getButtonHeight(index: Int) -> CGFloat {
        guard let data = paywall?.components[index] as? ButtonComponent else { return 0 }
        return data.height
    }
    
    func getButtonActionCode(index: Int) -> String? {
        guard let data = paywall?.components[index] as? ButtonComponent else { return nil }
        return data.actionCode
    }
    
    func getButtonTextColor(index: Int) -> UIColor? {
        guard let data = paywall?.components[index] as? ButtonComponent else { return nil }
        return UIColor(hex: data.textColor)
    }
    
    func getButtonBackgroundColor(index: Int) -> UIColor? {
        guard let data = paywall?.components[index] as? ButtonComponent else { return nil }
        return UIColor(hex: data.backgroundColor)
    }
    
    func getButtonTitleFont(index: Int) -> UIFont? {
        guard let data = paywall?.components[index] as? ButtonComponent else { return nil }
        return data.weight == .bold ? UIFont.boldSystemFont(ofSize: data.fontSize) : UIFont.systemFont(ofSize: data.fontSize)
    }
    
    // MARK: - Label
    
    func getLabelText(index: Int) -> String {
        guard let data = paywall?.components[index] as? LabelComponent else { return "" }
        return data.title
    }
    
    func getLabelTextColor(index: Int) -> UIColor? {
        guard let data = paywall?.components[index] as? LabelComponent else { return nil }
        return UIColor(hex: data.textColor)
    }
    
    func getLabelTextAlignment(index: Int) -> NSTextAlignment {
        guard let data = paywall?.components[index] as? LabelComponent else { return .center }
        switch data.titleAlignment {
        case .center:
            return .center
        }
    }
    
    func getLabelMaxLines(index: Int) -> Int {
        guard let data = paywall?.components[index] as? LabelComponent else { return 1 }
        return data.lines
    }
    
    func getLabelFont(index: Int) -> UIFont? {
        guard let data = paywall?.components[index] as? LabelComponent else { return nil }
        return data.weight == .bold ? UIFont.boldSystemFont(ofSize: data.fontSize) : UIFont.systemFont(ofSize: data.fontSize)
    }
    
    // MARK: - Image
    
    func getImageName(index: Int) -> String {
        guard let data = paywall?.components[index] as? ImageComponent else { return "" }
        return parseURLForFileName(url: data.assetURL)
    }
    
    func getImageHeight(index: Int) -> CGFloat {
        guard let data = paywall?.components[index] as? ImageComponent else { return 0 }
        return data.height
    }
    
    // MARK: - Separator
    
    func getSeparatorColor(index: Int) -> UIColor? {
        guard let data = paywall?.components[index] as? SeparatorComponent else { return nil }
        return UIColor(hex: data.color)
    }
    
    func getSeparatorHeight(index: Int) -> CGFloat {
        guard let data = paywall?.components[index] as? SeparatorComponent else { return 0 }
        return data.height
    }
    
    // MARK: - Private utils
    
    func parseURLForFileName(url: String) -> String {
        return (NSURLComponents(string: url)?.path as? NSString)?.lastPathComponent ?? ""
    }
}
