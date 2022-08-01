//
//  PaywallLayout.swift
//  Paywall
//
//  Created by Carolina Caceres on 8/1/22.
//  Copyright © 2022 Disney Streaming. All rights reserved.
//

import Foundation

class PaywallLayot: Codable {
    let metadata: Metadata
    let components: [Component]
    
    private enum CodingKeys: String, CodingKey {
        case metatada = "meta"
        case components
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        metadata = try container.decode(Metadata.self, forKey: CodingKeys.metatada)
        components = try container.decode([Component].self, forKey: CodingKeys.components)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(metadata, forKey: .metatada)
        try container.encode(components, forKey: .components)
    }
}
