//
//  TaskListVC.swift
//  lstr
//
//  Created by Taylor King on 12/14/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit

class TaskListVC: UIViewController {

    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var list: List!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listNameLabel.text = list.listName + ":"
    }
    
    
    @IBAction func backBtnTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addTaskBtnTapped(_ sender: AnyObject) {
    }

}
