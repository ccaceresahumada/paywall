//
//  LabelComponent.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

class LabelComponent: Component {

    var title: String = ""
    var textColor: String = ""
    var weight: ComponentWeight = .regular
    var titleAlignment: ComponentAlignment = .center
    var casing: ComponentCase = .none
    var lines: Int = 1
    var fontSize: CGFloat = 0

    private enum CodingKeys: String, CodingKey {
        case title
        case titleAlignment
        case casing
        case weight
        case textColor
        case lines
        case fontSize
    }
    
    // MARK: - Initializer
    
    private func privateInit() {
        self.type = .label
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
        weight = try container.decode(ComponentWeight.self, forKey: .weight)
        textColor = try container.decode(String.self, forKey: .textColor)
        lines = try container.decode(Int.self, forKey: .lines)
        fontSize = try container.decode(CGFloat.self, forKey: .fontSize)
        
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(titleAlignment, forKey: .titleAlignment)
        try container.encode(casing, forKey: .casing)
        try container.encode(weight, forKey: .weight)
        try container.encode(textColor, forKey: .textColor)
        try container.encode(lines, forKey: .lines)
        try container.encode(fontSize, forKey: .fontSize)
        
        try super.encode(to: encoder)
    }
}
