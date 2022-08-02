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
            guard let viewModel = viewModel else { return }
            createComponents(withViewModel: viewModel)
        }
    }
    
    // MARK: - Private properties

    /// Using an array to preserve the order of elements.
    /// - note: An enhancement is to be agnostic of the element order and use another mechanism to decide the order in which views are rendered.
    private var uiElements: [UIView] = [] {
        didSet {
            layoutUIElements()
        }
    }
    
    private var previousElement: UIView?

    // MARK: - Layout components
    
    private func createComponents(withViewModel viewModel: PaywallViewModel) {
        guard let paywall = viewModel.paywall else { return }
        var elements: [UIView] = []
        for index in 0..<paywall.components.count {
            let component = paywall.components[index]
            switch component.type {
            case .label:
                elements.append(ComponentBuilder().makeLabelComponent(withViewModel: viewModel, index: index))
            case .image:
                elements.append(ComponentBuilder().makeImageComponent(withViewModel: viewModel, index: index))
            case .separator:
                elements.append(ComponentBuilder().makeSeparatorComponent(withViewModel: viewModel, index: index))
            case .button:
                elements.append(ComponentBuilder().makeButtonComponent(withViewModel: viewModel, index: index))
            }
        }
        uiElements = elements
    }
    
    private func layoutUIElements() {
        for element in uiElements.reversed() {
            addElement(element)
        }
    }
    
    private func addElement(_ element: UIView) {
        addSubview(element)
        element.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ConstraintValue.leading).isActive = true
        element.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ConstraintValue.trailing).isActive = true
        element.bottomAnchor.constraint(equalTo: previousElement?.topAnchor ?? bottomAnchor, constant: -ConstraintValue.top).isActive = true
        previousElement = element
    }
}
