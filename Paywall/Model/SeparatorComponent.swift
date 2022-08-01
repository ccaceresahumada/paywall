//
//  SeparatorComponent.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

class SeparatorComponent: Component {
    
    var color: String = ""
    var height: CGFloat = 0
    
    private enum CodingKeys: String, CodingKey {
        case color
        case height
    }
    
    // MARK: - Initializer
    
    private func privateInit() {
        self.type = .separator
    }

    override init() {
        super.init()
        privateInit()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        color = try container.decode(String.self, forKey: .color)
        height = try container.decode(CGFloat.self, forKey: .height)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(color, forKey: .color)
        try container.encode(height, forKey: .height)
        
        try super.encode(to: encoder)
    }
}
