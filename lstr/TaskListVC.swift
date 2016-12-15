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
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.ds.REF_LISTS.child(list.listKey).child("tasks").observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.tasks = []
                for snap in snapshots {
                    
                    if let taskDict = snap.value as? Dictionary<String, AnyObject> {
                        print("TAYLOR: ---snap--- \(taskDict)")
                        self.tasks.append(Task(taskName: taskDict["name"] as! String, completed: taskDict["completed"] as! Bool))
                        self.tableView.reloadData()
                    }
                }
            }
            
        })
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
                let taskRef = tasksRef.child(taskName.lowercased())
                
                let task = Task(taskName: taskName, completed: false)
                taskRef.setValue(task.toAnyObject(), withCompletionBlock: { (error, ref) in
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


extension TaskListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let task = tasks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        cell.configureCell(task: task)
        
        return cell
    }
}






