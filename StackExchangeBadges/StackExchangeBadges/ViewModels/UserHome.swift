//
//  UserHome.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

struct UserHome {
    var badges: String
    var name: String
    var profileImgURL: URL?
    var reputation: String
    
    init(name: String,
         badgesCount: Int,
         profileImg: String?,
         reputation: Int) {
        
        self.name = name
        self.badges = "Badges: \(badgesCount)"
        self.reputation = "Reputation: \(reputation)"
        if let imageStr = profileImg {
            self.profileImgURL = URL(string: imageStr)
        }
    }
}
extension UserHome: UserViewModel {
    static func from(user: User) -> UserViewModel {
        
        var badges = 0
        if let badgeCounts = user.badgeCounts {
            badges = badgeCounts.bronze + badgeCounts.silver + badgeCounts.gold
        }
        
        return UserHome(name: user.name ?? "", badgesCount: badges, profileImg: user.profileImg, reputation: user.reputation ?? 0)
        
    }

}
