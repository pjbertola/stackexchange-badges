//
//  StackUserRepository.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 31/05/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

protocol StackUserRepository {
    var user: User? { get }
}


/// In memory User repository
class StackUser: StackUserRepository {
    //Read
    private(set) var user: User?
    
    //Write
    func setUser(user: User) {
        self.user = user
    }
}
