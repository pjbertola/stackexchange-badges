//
//  StackUserRepository.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 31/05/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

protocol StackUserRepository {
    //Read
    var user: User? { get }
    var code: String? { get }
    var accessToken: String? { get }
    func getUserHome() -> UserHome?
    
    //Write
    func setStackUser(_ user: User)
    func setLoginCode(_ code: String)
    func setToken(_ code: String)
    func clearLogin()
}


/// In memory User repository
class StackUser: StackUserRepository {

    
    //MARK:- Properties
    private(set) var user: User?
    private(set) var code: String?
    private(set) var accessToken: String?
    
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
}
