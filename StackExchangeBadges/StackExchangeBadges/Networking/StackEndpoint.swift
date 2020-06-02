//
//  StackEndpoint.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 01/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation

enum StackExchangeApp: String {
    case clientId = "17994"
    case clientSecret = "lE4qF6BtsRZ1W3f8Tm68ZA(("
    case publicKey = "n4nXEweqKaE*PcC6IDj*bg(("
    case redirect = "https://pjb.com.ar/login_success"
    case baseURL = "https://stackoverflow.com"
    case baseApi = "https://api.stackexchange.com/2.2"
}

enum httpMethod: String {
    case GET
    case POST
}

protocol Endpoint {
    var url: URL? { get }
    var method: httpMethod { get }
}
enum StackEndpoint {
    case oauth
    case accessToken(code: String)
    case me(token: String)
    case myBaggets(token: String)
    
    var url: URL? {
        switch self {
        case .oauth:
            return URL(string: "\(StackExchangeApp.baseURL.rawValue)/oauth?client_id=\(StackExchangeApp.clientId.rawValue)&scope=private_info&redirect_uri=\(StackExchangeApp.redirect.rawValue)")
            
        case .accessToken(let code):
            return URL(string: "\(StackExchangeApp.baseURL.rawValue)/oauth/access_token/json?client_id=\(StackExchangeApp.clientId.rawValue)&client_secret=\(StackExchangeApp.clientSecret.rawValue)&redirect_uri=\(StackExchangeApp.redirect.rawValue)&code=\(code)")
            
        case .me(let token):
            return URL(string: "\(StackExchangeApp.baseApi.rawValue)/me?order=desc&sort=reputation&site=stackoverflow&key=\(StackExchangeApp.publicKey.rawValue)&access_token=\(token)")
            
        case .myBaggets(let token):
            return URL(string: "\(StackExchangeApp.baseApi.rawValue)/me/badges?order=desc&sort=type&site=stackoverflow&key=\(StackExchangeApp.publicKey.rawValue)&access_token=\(token)")

        }
    }
    
    var method: httpMethod {
        switch self {
        case .oauth:
            return .GET
        case .accessToken(_):
            return .POST
        case .me(_):
            return .GET
        case .myBaggets(_):
            return .GET
        }
    }
}
