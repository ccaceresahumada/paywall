//
//  ButtonComponent.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

class ButtonComponent: Component {
    
    var title: String = ""
    var titleAlignment: ComponentAlignment = .center
    var casing: ComponentCase = .upper
    var height: CGFloat = 0
    var backgroundColor: String = ""
    var textColor: String = ""
    var actionCode: String = ""

    private enum CodingKeys: String, CodingKey {
        case title
        case titleAlignment
        case casing
        case height
        case backgroundColor
        case textColor
        case actionCode
    }
    
    // MARK: - Initializer
    
    private func privateInit() {
        self.type = .button
    }

    override init() {
        super.init()
        privateInit()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        titleAlignment = try container.decode(ComponentAlignment.self, forKey: .titleAlignment)
        casing = try container.decode(ComponentCase.self, forKey: .casing)
        height = try container.decode(CGFloat.self, forKey: .height)
        textColor = try container.decode(String.self, forKey: .textColor)
        backgroundColor = try container.decode(String.self, forKey: .backgroundColor)
        actionCode = try container.decode(String.self, forKey: .actionCode)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(titleAlignment, forKey: .titleAlignment)
        try container.encode(casing, forKey: .casing)
        try container.encode(height, forKey: .height)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(textColor, forKey: .textColor)
        try container.encode(actionCode, forKey: .actionCode)
        
        try super.encode(to: encoder)
    }
}
