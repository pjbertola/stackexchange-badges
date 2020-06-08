//
//  UserViewModelTests.swift
//  StackExchangeBadgesTests
//
//  Created by Pablo Javier Bertola on 08/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import XCTest
@testable import StackExchangeBadges

// Extension for UserViewModel Tests
extension StackExchangeBadgesTests {
    
    func testUserHome() {
        let badgeCounts = BadgeCounts(bronze: 1, gold: 2, silver: 3)
        let user = User(badgeCounts: badgeCounts, name: "Pablo J. Bertola", profileImg: "", reputation: 10)
        if let userHome = UserHome.from(user: user) as? UserHome {
            
            XCTAssertEqual(userHome.name, "Pablo J. Bertola")
            XCTAssertEqual(userHome.badges, "Badges: 6")
            XCTAssertEqual(userHome.reputation, "Reputation: 10")
            
        } else {
            XCTFail("UserViewModel isn´t a UserHome")
        }

        
    }
}
