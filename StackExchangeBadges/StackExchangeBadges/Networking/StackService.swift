//
//  StackService.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 01/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation
typealias ServiceCompletionHandler = (_ success: Bool, _ error: Error?) -> ()

class StackService{
    //MARK:- Properties
    let repository: StackUserRepository
    
    //MARK:- Methods
    init(withRepository stackRepository: StackUserRepository) {
        repository = stackRepository
    }
    
    func getAccessToken(completion: ServiceCompletionHandler?){
        guard let code = repository.code else {
            completion?(false, nil)
            return
        }
        let endpoint = StackEndpoint.accessToken(code: code)
               guard let url = endpoint.url else { return }
               
               var request = URLRequest(url: url)
               request.httpMethod = endpoint.method.rawValue

               let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                   do {
                       guard let data = data else { return }
                       
                       let accesTokenData = try JSONDecoder().decode(AccesTokenData.self, from: data)
                                       
                       DispatchQueue.main.async {
                            if let token = accesTokenData.accessToken {
                                self?.repository.setToken(token)
                                completion?(true,  nil)
                            }else {
                                completion?(false,  nil)
                            }
                       }
                   } catch {
                       DispatchQueue.main.async {
                           completion?(false,  error)
                       }
                   }

               }
               task.resume()
    }
    
    func getMe(completion: ServiceCompletionHandler?){
        guard let token = repository.accessToken else {
            completion?(false, nil)
            return
        }
        let endpoint = StackEndpoint.me(token: token)
               guard let url = endpoint.url else { return }
               
               var request = URLRequest(url: url)
               request.httpMethod = endpoint.method.rawValue
                
               let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                   do {
                       guard let data = data else { return }
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                       let userData = try JSONDecoder().decode(UserData.self, from: data)
                                       
                       DispatchQueue.main.async {
                        if let user = userData.items.first {
                            self?.repository.setStackUser(user)
                                completion?(true,  nil)
                            }else {
                                completion?(false,  nil)
                            }
                       }
                   } catch {
                     print("Unexpected error: \(error)")
                       DispatchQueue.main.async {
                           completion?(false,  error)
                       }
                   }

               }
               task.resume()
    }
}
