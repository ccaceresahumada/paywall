//
//  ComponentBuilder.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

protocol ComponentBuilderFactory {
    func makeButtonComponent(withViewModel viewModel: PaywallViewModel, index: Int) -> UIButton
    func makeLabelComponent(withViewModel viewModel: PaywallViewModel, index: Int) -> UILabel
    func makeImageComponent(withViewModel viewModel: PaywallViewModel, index: Int) -> UIImageView
    func makeSeparatorComponent(withViewModel viewModel: PaywallViewModel, index: Int) -> UIView
}

struct ComponentBuilder: ComponentBuilderFactory {

    func makeButtonComponent(withViewModel viewModel: PaywallViewModel, index: Int) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.text = viewModel.getButtonTitle(index: index)
        button.titleLabel?.textColor = viewModel.getButtonTextColor(index: index)
        button.titleLabel?.textAlignment = viewModel.getButtonTextAlignment(index: index)
        button.titleLabel?.font = viewModel.getButtonTitleFont(index: index)
        button.backgroundColor = viewModel.getButtonBackgroundColor(index: index)
        button.heightAnchor.constraint(equalToConstant: viewModel.getButtonHeight(index: index)).isActive = true
        return button
    }
    
    func makeLabelComponent(withViewModel viewModel: PaywallViewModel, index: Int) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.getLabelText(index: index)
        label.textColor = viewModel.getLabelTextColor(index: index)
        label.textAlignment = viewModel.getLabelTextAlignment(index: index)
        label.numberOfLines = viewModel.getLabelMaxLines(index: index)
        label.lineBreakMode = .byWordWrapping
        label.font = viewModel.getLabelFont(index: index)
        return label
    }
    
    func makeImageComponent(withViewModel viewModel: PaywallViewModel, index: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: viewModel.getImageName(index: index))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: viewModel.getImageHeight(index: index)).isActive = true
        return imageView
    }
    
    func makeSeparatorComponent(withViewModel viewModel: PaywallViewModel, index: Int) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = viewModel.getSeparatorColor(index: index)
        view.heightAnchor.constraint(equalToConstant: viewModel.getSeparatorHeight(index: index)).isActive = true
        return view
    }
}
