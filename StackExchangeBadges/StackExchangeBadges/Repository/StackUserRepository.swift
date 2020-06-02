//
//  StackUserRepository.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 31/05/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

enum SortBadge {
    case id
    case rank
}
enum BadgeRank: String, CaseIterable {
    case gold
    case silver
    case bronze
}
protocol StackUserRepository {
    var user: User? { get }
    var code: String? { get }
    var accessToken: String? { get }
    var myBadges: [Badge] { get }
    var myBadgesSort: SortBadge { get }
    
    //Read
    func getUserHome() -> UserHome?
    
    //Write
    func setStackUser(_ user: User)
    func setLoginCode(_ code: String)
    func setToken(_ code: String)
    func clearLogin()
    func setMyBadges(_ badges: [Badge])
    func getChangedSortMyBudget() -> [MyBadge]
}


/// In memory User repository
class StackUser: StackUserRepository {

    //MARK:- Properties
    private(set) var user: User?
    private(set) var code: String?
    private(set) var accessToken: String?
    private(set) var myBadges: [Badge] = []
    private(set) var myBadgesSort = SortBadge.id
    
    //MARK:- Methods
    init() {
        //build a keychain manager to store this data would be a better option.
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "AccessToken") {
            self.accessToken = token
        }
    }
    //Read
    func getUserHome() -> UserHome? {
        guard let user = user else {
            return nil
        }
        return UserHome.from(user: user) as? UserHome
    }
    
    private func getMyBudgets(sortBy: SortBadge = .id) -> [MyBadge] {
        let sortedBadges = myBadges.sorted {
            switch (sortBy) {
            case .id:
                return $0.id < $1.id
            case .rank:
                if let rank0 = BadgeRank(rawValue: $0.rank),
                    let rank1 = BadgeRank(rawValue: $1.rank) {
                    let index0 = BadgeRank.allCases.firstIndex(of: rank0) ?? BadgeRank.allCases.count
                    let index1 = BadgeRank.allCases.firstIndex(of: rank1) ?? BadgeRank.allCases.count
                    return index0 < index1
                } else {
                    return false
                }
            }
        }
        var badgeList = [MyBadge]()
        for badge in sortedBadges {
            badgeList.append(MyBadge.from(badge: badge) as! MyBadge)
        }
        return badgeList
    }
    func getChangedSortMyBudget() -> [MyBadge] {
        switch myBadgesSort {
        case .id:
            myBadgesSort = .rank
        case .rank:
            myBadgesSort = .id
        }
        return getMyBudgets(sortBy: myBadgesSort)
    }
    
    
    //Write
    func setStackUser(_ user: User) {
        self.user = user
    }
    func setLoginCode(_ code: String){
        self.code = code
    }
    func setToken(_ token: String){
        self.accessToken = token
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "AccessToken")
    }
    func clearLogin() {
        self.code = nil
        self.accessToken = nil
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "AccessToken")
    }
    func setMyBadges(_ badges: [Badge]) {
        self.myBadges = badges
    }
}
