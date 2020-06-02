//
//  StackUserRepository.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 31/05/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

enum SortBadget {
    case id
    case rank
}
enum BadgetRank: String, CaseIterable {
    case gold
    case silver
    case bronze
}
protocol StackUserRepository {
    var user: User? { get }
    var code: String? { get }
    var accessToken: String? { get }
    var myBadgets: [Badget] { get }
    var myBadgetsSort: SortBadget { get }
    
    //Read
    func getUserHome() -> UserHome?
    
    //Write
    func setStackUser(_ user: User)
    func setLoginCode(_ code: String)
    func setToken(_ code: String)
    func clearLogin()
    func setMyBadgets(_ bagdets: [Badget])
    func getChangedSortMyBudget() -> [MyBadget]
}


/// In memory User repository
class StackUser: StackUserRepository {

    //MARK:- Properties
    private(set) var user: User?
    private(set) var code: String?
    private(set) var accessToken: String?
    private(set) var myBadgets: [Badget] = []
    private(set) var myBadgetsSort = SortBadget.id
    
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
    
    private func getMyBudgets(sortBy: SortBadget = .id) -> [MyBadget] {
        let sortedBadgets = myBadgets.sorted {
            switch (sortBy) {
            case .id:
                return $0.id < $1.id
            case .rank:
                if let rank0 = BadgetRank(rawValue: $0.rank),
                    let rank1 = BadgetRank(rawValue: $1.rank) {
                    let index0 = BadgetRank.allCases.firstIndex(of: rank0) ?? BadgetRank.allCases.count
                    let index1 = BadgetRank.allCases.firstIndex(of: rank1) ?? BadgetRank.allCases.count
                    return index0 < index1
                } else {
                    return false
                }
            }
        }
        var badgetList = [MyBadget]()
        for badget in sortedBadgets {
            badgetList.append(MyBadget.from(badget: badget) as! MyBadget)
        }
        return badgetList
    }
    func getChangedSortMyBudget() -> [MyBadget] {
        switch myBadgetsSort {
        case .id:
            myBadgetsSort = .rank
        case .rank:
            myBadgetsSort = .id
        }
        return getMyBudgets(sortBy: myBadgetsSort)
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
    func setMyBadgets(_ bagdets: [Badget]) {
        self.myBadgets = bagdets
    }
}
