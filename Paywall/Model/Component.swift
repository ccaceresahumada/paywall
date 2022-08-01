//
//  Component.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation

enum ComponentWeight: String, Codable {
    case bold
    case regular
}

enum ComponentCase: String, Codable {
    case camel
    case upper
    case lower
    case snake
}

enum ComponentType: String, Codable {
    case image
    case label
    case button
    case separator
}

enum ComponentAlignment: String, Codable {
    case center
}

class Component: Codable {
    var type: ComponentType = .label
    var alignment: ComponentAlignment = .center
    var widthPercentage: Float = 1
    
    private enum CodingKeys: String, CodingKey {
        case type
        case alignment
        case widthPercentage
    }
    
    // MARK: - Initializers
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(ComponentType.self, forKey: .type)
        alignment = try container.decode(ComponentAlignment.self, forKey: .alignment)
        widthPercentage = try container.decode(Float.self, forKey: .widthPercentage)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(alignment, forKey: .alignment)
        try container.encode(widthPercentage, forKey: .widthPercentage)
    }
}
