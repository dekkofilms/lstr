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
        
        tableView.estimatedRowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        
        DataService.ds.REF_LISTS.child(list.listKey).child("tasks").observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.tasks = []
                for snap in snapshots {
                    if let taskDict = snap.value as? Dictionary<String, AnyObject> {
                        print("TAYLOR: ---snap--- \(snap.key)")
                        self.tasks.append(Task(taskName: taskDict["name"] as! String, completed: taskDict["completed"] as! Bool, taskKey: snap.key))
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.listNameLabel.text = list.listName
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
                let taskRef = tasksRef.childByAutoId()
                
                let task = ["name" : taskName, "completed" : false] as [String : Any]
                taskRef.setValue(task, withCompletionBlock: { (error, ref) in
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc(tableView:editActionsForRowAtIndexPath:) func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let task = tasks[indexPath.row]
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, indexPath in
            print("TAYLOR \(task.taskKey)")
            
            let alertController: UIAlertController = UIAlertController(title: "Edit Task", message: "", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addTextField { (textField) in
                textField.placeholder = task.taskName
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (result) in
                print("TAYLOR: action cancelled")
            })
            
            let okAction = UIAlertAction(title: "Enter", style: UIAlertActionStyle.default, handler: { (result) in
                if let updatedValue = alertController.textFields?.first?.text {
                    DataService.ds.REF_LISTS.child(self.list.listKey).child("tasks").child(task.taskKey).updateChildValues(["name" : updatedValue])
                }
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        edit.backgroundColor = UIColor.lightGray
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, indexPath in
            print("TAYLOR \(task)")
            DataService.ds.REF_LISTS.child(self.list.listKey).child("tasks").child(task.taskKey).removeValue()
            print("favorite button tapped")
        }
        delete.backgroundColor = UIColor.red
        
        return [delete, edit]
    }
    
}

extension TaskListVC: UITableViewDelegate {
    @objc(tableView:commitEditingStyle:forRowAtIndexPath:) func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //apparently this method does nothing, and i hate that, but you need this
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as! TaskCell! else { return }
        
        let task = tasks[indexPath.row]
        let toggledCompletion = !task.completed
        
        cell.toggleCompletion(cell, toggledCompletion: toggledCompletion)
        
        DataService.ds.REF_LISTS.child(list.listKey).child("tasks").child(task.taskKey).updateChildValues(["completed" : toggledCompletion])
            
            
    }
}






