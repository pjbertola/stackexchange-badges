//
//  ViewController.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 31/05/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- Properties
    
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var badgeValueLb: UILabel!
    @IBOutlet weak var reputationValueLb: UILabel!
    var repository: StackUserRepository!
    var service: StackService!
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        service = StackService(withRepository: repository)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !(repository.code == nil) && (repository.accessToken == nil) {
            //get token
            getToken()
        } else if (repository.accessToken == nil) {
            //login
            showLogin()
        } else if repository.user == nil {
            getMe()
        }
    }
    
    func showLogin() {
        let loginVC = LoginWebViewController()
        loginVC.repository = repository
        show(loginVC, sender: self)
    }
    
    func getToken() {
        service.getAccessToken { [weak self] (success, error) in
             guard error == nil else {
                 let alert = UIAlertController(title: "Error",
                                               message: "An Error ocurred while attempting to retrieve Token, please try again later",
                                               preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "Dismiss",
                                               style: .cancel,
                                               handler: nil))
                 self?.present(alert, animated: true, completion: nil)
                 
                 //clear credentials
                 self?.repository.clearLogin()
                 return
             }
             
             if success {
                 DispatchQueue.main.async {
                    self?.getMe()
                 }
             } else {
                 self?.repository.clearLogin()
             }
         }
    }
    
    func getMe(){
        //get user
        service.getMe { [weak self] (success, error) in
            if success {
                DispatchQueue.main.async {
                   self?.updateView()
                }
            } else {

                self?.repository.clearLogin()
                let alert = UIAlertController(title: "Error",
                                              message: "An Error ocurred while attempting to retrieve Token, please try again later",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss",
                                              style: .cancel,
                                              handler: nil))

                DispatchQueue.main.async {
                    self?.present(alert, animated: true, completion: nil)
                   self?.showLogin()
                }
            }
        }
    }
    
    func updateView(){
        //update View
        print("updateView!!!!!!!!")
    }

}

