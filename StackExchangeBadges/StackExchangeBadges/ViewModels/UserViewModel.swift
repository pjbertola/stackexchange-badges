//
//  UserViewModel.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

protocol UserViewModel {
    static func from(user: User) -> UserViewModel
}
