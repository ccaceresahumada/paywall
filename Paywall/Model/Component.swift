//
//  Component.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

enum ComponentWeight: String, Codable {
    case bold
    case regular
}

enum ComponentCase: String, Codable {
    case camel
    case upper
    case lower
    case snake
    case none
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

protocol ComponentFamily: Decodable {
    static var discriminator: Discriminator { get }
    func getType() -> AnyObject.Type
}

enum Discriminator: String, CodingKey {
    case type = "type"
}

enum UIElementFamily: String, ComponentFamily {
    case label
    case image
    case button
    case separator
    
    static var discriminator: Discriminator = .type
    
    func getType() -> AnyObject.Type {
        switch self {
        case .label:
            return LabelComponent.self
        case .image:
            return ImageComponent.self
        case .button:
            return ButtonComponent.self
        case .separator:
            return SeparatorComponent.self
        }
    }
}

class ComponentConstraint: Codable {
    var leading: CGFloat = 0
    var trailing: CGFloat = 0
    var top: CGFloat = 0
    var bottom: CGFloat = 0
    
    private enum CodingKeys: String, CodingKey {
        case leading
        case trailing
        case top
        case bottom
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        leading = try container.decode(CGFloat.self, forKey: .leading)
        trailing = try container.decode(CGFloat.self, forKey: .trailing)
        top = try container.decode(CGFloat.self, forKey: .top)
        bottom = try container.decode(CGFloat.self, forKey: .bottom)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(leading, forKey: .leading)
        try container.encode(trailing, forKey: .trailing)
        try container.encode(top, forKey: .top)
        try container.encode(bottom, forKey: .bottom)
    }
}

class Component: Codable {
    var type: ComponentType = .label
    var alignment: ComponentAlignment = .center
    var widthPercentage: CGFloat = 1
    var constraints: ComponentConstraint = ComponentConstraint()
    
    private enum CodingKeys: String, CodingKey {
        case type
        case alignment
        case widthPercentage
        case constraints
    }
    
    // MARK: - Initializers
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(ComponentType.self, forKey: .type)
        alignment = try container.decode(ComponentAlignment.self, forKey: .alignment)
        widthPercentage = try container.decode(CGFloat.self, forKey: .widthPercentage)
        constraints = try container.decode(ComponentConstraint.self, forKey: .constraints)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(alignment, forKey: .alignment)
        try container.encode(widthPercentage, forKey: .widthPercentage)
        try container.encode(constraints, forKey: .constraints)
    }
}
