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
    
    
    //MARK:- Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}

