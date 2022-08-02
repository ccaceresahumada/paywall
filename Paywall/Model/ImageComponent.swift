//
//  ImageComponent.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

class ImageComponent: Component {
    
    var assetURL: String = ""
    var height: CGFloat = 0

    private enum CodingKeys: String, CodingKey {
        case assetURL = "asset"
        case height
    }
    
    // MARK: - Initializer
    
    private func privateInit() {
        self.type = .image
    }

    override init() {
        super.init()
        privateInit()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        assetURL = try container.decode(String.self, forKey: .assetURL)
        height = try container.decode(CGFloat.self, forKey: .height)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(assetURL, forKey: .assetURL)
        try container.encode(height, forKey: .height)
        
        try super.encode(to: encoder)
    }
}
