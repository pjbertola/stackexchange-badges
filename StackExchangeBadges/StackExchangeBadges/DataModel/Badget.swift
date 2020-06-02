//
//  Badget.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

struct Badget: Codable {
    var id: Int
    var rank: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "badge_id"
        case rank
        case description
    }
    
}
