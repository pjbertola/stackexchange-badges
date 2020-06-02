//
//  MyBadgesViewControllers.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation
import UIKit
class MyBadgesViewControllers: UIViewController {
    //MARK:- Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewsToHide: [UIView]!
    
    var badgeList = [MyBadge]()
    var repository: StackUserRepository!
    var service: StackService!
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: BadgeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BadgeTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        viewsToHide.hide(animated: false)
        service.getMyBadges {[weak self] (success, error) in
            if success {
                if let list = self?.repository.getChangedSortMyBudget(){
                    self?.badgeList = list
                    self?.tableView.reloadData()
                }
            }
            self?.viewsToHide.show(animated: true)
        }
    }
    @IBAction func changeSort(_ sender: UIButton) {
        badgeList = repository.getChangedSortMyBudget()
        tableView.reloadData()
    }
    
}
extension MyBadgesViewControllers: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        badgeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BadgeTableViewCell.identifier, for: indexPath) as? BadgeTableViewCell
        cell?.setUp(myBadge: badgeList[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
