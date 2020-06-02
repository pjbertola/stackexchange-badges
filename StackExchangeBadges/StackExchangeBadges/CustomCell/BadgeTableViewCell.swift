//
//  BadgeTableViewCell.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation
import UIKit

class BadgeTableViewCell: UITableViewCell {
    //MARK:- Properties
    static let identifier = "BadgeTableViewCell"
    @IBOutlet weak var rankImgView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    //MARK:- Methods
    func setUp(myBadge: MyBadge) {
        rankImgView.image = UIImage(named: myBadge.rank)
        titleLb.text = myBadge.description
    }
}
