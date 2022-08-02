//
//  CustomPaywallView.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

protocol CustomPaywallViewDelegate: AnyObject {
    func displayAlert(withMessage message: String)
}

class CustomPaywallView: UIView {
    
    // MARK: - Internal properties
    
    weak var delegate: CustomPaywallViewDelegate?
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
            clearSubviews()
            layoutUIElements()
        }
    }
    
    private var uiElementsConstraints: [ComponentConstraint] = []
    private var previousElement: UIView?

    // MARK: - Layout components
    
    private func createComponents(withViewModel viewModel: PaywallViewModel) {
        guard let paywall = viewModel.paywall else { return }
        var elements: [UIView] = []
        var elementsConstraints: [ComponentConstraint] = []
        for index in 0..<paywall.components.count {
            let component = paywall.components[index]
            let constraints = viewModel.getComponentConstraints(index: index)
            switch component.type {
            case .label:
                elements.append(ComponentBuilder().makeLabelComponent(withViewModel: viewModel, index: index))
                elementsConstraints.append(constraints)
            case .image:
                elements.append(ComponentBuilder().makeImageComponent(withViewModel: viewModel, index: index))
                elementsConstraints.append(constraints)
            case .separator:
                elements.append(ComponentBuilder().makeSeparatorComponent(withViewModel: viewModel, index: index))
                elementsConstraints.append(constraints)
            case .button:
                let button = ComponentBuilder().makeButtonComponent(withViewModel: viewModel, index: index)
                button.addTarget(self, action: #selector(didTapOnButtonWithActionCode(sender:)), for: .touchUpInside)
                elements.append(button)
                elementsConstraints.append(constraints)
            }
        }
        
        uiElementsConstraints = elementsConstraints
        uiElements = elements
    }
    
    private func clearSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
        previousElement = nil
    }
    
    private func layoutUIElements() {
        for i in (0..<uiElements.count).reversed() {
            addElement(uiElements[i], withConstraints: uiElementsConstraints[i])
        }
    }
    
    private func addElement(_ element: UIView, withConstraints constraints: ComponentConstraint) {
        addSubview(element)
        
        if let leading = constraints.leading {
            element.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading).isActive = true
        }
        
        if let trailing = constraints.trailing {
            element.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trailing).isActive = true
        }
        
        if let previousElement = previousElement, let bottom = constraints.bottom {
            element.bottomAnchor.constraint(equalTo: previousElement.topAnchor, constant: -bottom).isActive = true
        } else {
            element.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
        if let centerX = constraints.centerX, let viewModel = viewModel {
            element.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerX).isActive = true
            element.widthAnchor.constraint(equalToConstant: viewModel.getComponentWidthPercentage(index: 0) * UIScreen.main.bounds.width).isActive = true
        }
        
        previousElement = element
    }
    
    @objc func didTapOnButtonWithActionCode(sender: Any) {
        if
            let button = sender as? CustomButton,
            let code = button.actionCode,
            let action = ActionCode(rawValue: code) {
            switch action {
            case .loginButtonTapped:
                delegate?.displayAlert(withMessage: "Log In")
            default:
                delegate?.displayAlert(withMessage: "Purchase \(action.rawValue)")
            }
        }
    }
}
