//
//  BadgetTableViewCell.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation
import UIKit

class BadgetTableViewCell: UITableViewCell {
    //MARK:- Properties
    static let identifier = "BadgetTableViewCell"
    @IBOutlet weak var rankImgView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    //MARK:- Methods
    func setUp(myBadget: MyBadget) {
        rankImgView.image = UIImage(named: myBadget.rank)
        titleLb.text = myBadget.description
    }
}
