//
//  StackListings.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 01/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

struct AccesTokenData: Codable {
    var accessToken: String?
    var expires: Int?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expires
    }
}

struct BaseData<T: Codable>: Codable {
    var items: [T]?
}

