//
//  TaskListVC.swift
//  lstr
//
//  Created by Taylor King on 12/14/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit
import Firebase

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
        
        let alertController: UIAlertController = UIAlertController(title: "Add a Task", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Task Here"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result) in
            print("cancel")
        }
        
        let okAction = UIAlertAction(title: "Enter", style: UIAlertActionStyle.default) { (result) in
            print("TAYLOR: \(alertController.textFields?.first?.text)")
            
            let tasksRef = DataService.ds.REF_LISTS.child(self.list.listKey).child("tasks")
                
            if let taskName = alertController.textFields?.first?.text {
                let task = Task(taskName: taskName, completed: false)
                print("TAYLOR: ---task--- \(type(of: task))")
                tasksRef.setValue(task, withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print("TAYLOR: unable to push into database \(error)")
                    } else {
                        print("TAYLOR: successfully made it into the database \(ref)")
                    }
                })
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true) {
            print("TAYLOR: oh hai")
        }
    }

}
