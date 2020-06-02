//
//  MyBadgetsViewControllers.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 02/06/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation
import UIKit
class MyBadgetsViewControllers: UIViewController {
    //MARK:- Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var viewsToHide: [UIView]!
    
    var badgetList = [MyBadget]()
    var repository: StackUserRepository!
    var service: StackService!
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: BadgetTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BadgetTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        viewsToHide.hide(animated: false)
        service.getMyBadgets {[weak self] (success, error) in
            if success {
                if let list = self?.repository.getChangedSortMyBudget(){
                    self?.badgetList = list
                    self?.tableView.reloadData()
                }
            }
            self?.viewsToHide.show(animated: true)
        }
    }
    @IBAction func changeSort(_ sender: UIButton) {
        badgetList = repository.getChangedSortMyBudget()
        tableView.reloadData()
    }
    
}
extension MyBadgetsViewControllers: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        badgetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BadgetTableViewCell.identifier, for: indexPath) as? BadgetTableViewCell
        cell?.setUp(myBadget: badgetList[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
