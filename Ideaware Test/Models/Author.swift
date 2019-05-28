//
//  Author.swift
//  Ideaware Test
//
//  Created by Miguel Roncallo on 5/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation

struct Author: Codable{
    var account: String?
    var name: String?
    var picture: String?
    var verified: Bool?
    
    private enum authorEncodingKeys: String, CodingKey{
        case account = "account"
        case name
        case picture = "picture-link"
        case verified = "is-verified"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: authorEncodingKeys.self)
        
        account = try container.decodeIfPresent(String.self, forKey: .account)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        picture = try container.decodeIfPresent(String.self, forKey: .picture)
        verified = try container.decode(Bool.self, forKey: .verified)
    }
}
