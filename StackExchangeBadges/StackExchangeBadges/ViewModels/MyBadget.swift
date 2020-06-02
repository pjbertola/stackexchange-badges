//
//  MyBadget.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

struct MyBadget {
    var rank: String
    var description: String
    
}

extension MyBadget: BadgetViewModel {
    static func from(badget: Badget) -> BadgetViewModel {
        return MyBadget(rank: badget.rank, description: badget.description)
    }
}
