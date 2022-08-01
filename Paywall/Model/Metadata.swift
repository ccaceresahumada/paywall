//
//  Metadata.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation
import UIKit

struct Metadata: Codable {
    let backgroundImage: String
    let backgroundColor: String
    let fontFamily: String
    let identifier: String

    enum CodingKeys: String, CodingKey {
        case backgroundImage
        case backgroundColor
        case fontFamily
        case identifier
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        backgroundColor = try container.decode(String.self, forKey: .backgroundColor)
        fontFamily = try container.decode(String.self, forKey: .fontFamily)
        identifier = try container.decode(String.self, forKey: .identifier)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(backgroundImage, forKey: .backgroundImage)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(fontFamily, forKey: .fontFamily)
        try container.encode(identifier, forKey: .identifier)
    }
}
