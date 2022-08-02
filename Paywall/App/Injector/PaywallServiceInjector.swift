//
//  NetworkInjector.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/2/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation

struct InjectionMap {
    fileprivate static var paywallService = PaywallService()
}

protocol PaywallServiceInjector {}

extension PaywallServiceInjector {
    var paywallService: PaywallService {
        return InjectionMap.paywallService
    }
    
    func replacePaywallServiceReference(_ service: PaywallService) {
        InjectionMap.paywallService = service
    }
}
