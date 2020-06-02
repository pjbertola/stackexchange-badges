//
//  MyBadge.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

struct MyBadge {
    var rank: String
    var description: String
    
}

extension MyBadge: BadgeViewModel {
    static func from(badge: Badge) -> BadgeViewModel {
        return MyBadge(rank: badge.rank, description: badge.description)
    }
}
