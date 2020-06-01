//
//  User.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 31/05/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

struct User: Codable {
    var badgeCounts: BadgeCounts?
    var name: String?
    var profileImg: String?
    var reputation: Int?
    
    enum CodingKeys: String, CodingKey {
        case badgeCounts = "badge_counts"
        case name = "display_name"
        case profileImg = "profile_image"
        case reputation
    }
}
