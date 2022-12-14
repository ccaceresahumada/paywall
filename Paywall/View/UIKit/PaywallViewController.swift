//
//  PaywallViewController.swift
//  Paywall
//
//  Copyright © 2020 Disney Streaming. All rights reserved.
//

import UIKit

class PaywallViewController: UIViewController, PaywallViewModelDelegate, CustomPaywallViewDelegate {
    
    // MARK: - UI Components
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var customPaywall: CustomPaywallView = {
        let paywall = CustomPaywallView()
        paywall.translatesAutoresizingMaskIntoConstraints = false
        return paywall
    }()
    
    // MARK: - Private properties
    
    private var viewModel: PaywallViewModel?

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = PaywallViewModel(type: .disney, delegate: self)
        viewModel?.reloadData()
        
        customPaywall.delegate = self
        
        layout()
    }
    
    // MARK: - Layout
    
    private func clearSubviews() {
        view.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func layout() {
        clearSubviews()
        layoutBackgroundImage()
        layoutCustomPaywallView()
    }
    
    private func layoutBackgroundImage() {
        view.addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: (-0.35) * UIScreen.main.bounds.height).isActive = true
    }
    
    private func layoutCustomPaywallView() {
        view.addSubview(customPaywall)
        customPaywall.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height / 3).isActive = true
        customPaywall.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customPaywall.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        customPaywall.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - UIResponder
    
    func didShake() {
        viewModel = PaywallViewModel(type: .espn, delegate: self)
        viewModel?.reloadData()
    }
    
    // MARK: - PaywallViewModelDelegate
    
    func paywallUpdatedSuccessfully() {
        guard let viewModel = viewModel else { return }
        view.backgroundColor = viewModel.getBackgroundColor()
        backgroundImageView.image = UIImage(named: viewModel.getBackgroundImageName())
        customPaywall.viewModel = viewModel
        layout()
    }
    
    func paywallFailedToUpdate(_ error: Error?) {
        print("Failed to upload paywall data. \(error?.localizedDescription ?? "")")
    }
    
    // MARK: - Alert
    
    func displayAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
