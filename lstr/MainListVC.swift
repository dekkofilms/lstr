//
//  ViewController.swift
//  lstr
//
//  Created by Taylor King on 12/12/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class MainListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var lists = [List]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userKey = KeychainWrapper.standard.string(forKey: KEY_UID) {
            DataService.ds.REF_USERS.child(userKey).child("lists").observe(.value, with: { (snapshot) in
                if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    print("TAYLOR-SNAPSHOT: \(snapshots)")
                    
                    
                    self.lists = []
                    for snap in snapshots {
                        print("TAYLOR: snap ---- \(snap)")
                        if let listDict = snap.value as? Dictionary<String, AnyObject> {
                            print("TAYLOR: \(listDict)")
                            self.lists.append(List(name: listDict["name"] as! String, key: snap.key))
                            self.tableView.reloadData()
                        }
                        //if let listName = snap["name"] as? String {
                        //print("TAYLOR: \(listName)")
                        //let list = List(name: snap.name)
                        //}
                    }
                }
            })
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("TAYLOR: Hit this function")
        let user = KeychainWrapper.standard.string(forKey: KEY_UID)
        print("TAYLOR: \(user)")
        if user == nil {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let signInVC = sb.instantiateViewController(withIdentifier: "SignInVC")
                
            present(signInVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func signOutBtnTapped(_ sender: AnyObject) {
        do {
            try FIRAuth.auth()?.signOut()
            KeychainWrapper.standard.removeObject(forKey: KEY_UID)
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let signInVC = sb.instantiateViewController(withIdentifier: "SignInVC")
            
            present(signInVC, animated: false, completion: nil)
            
        } catch let signOutError as NSError {
            print("TAYLOR: Error signing out: \(signOutError)")
        }
        
    }
    
    
    @IBAction func addNewListBtnTapped(_ sender: AnyObject) {
        let alertController: UIAlertController = UIAlertController(title: "Add a New List", message: "Make a new list", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter List Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result) in
            print("cancel")
        }
        
        let okAction = UIAlertAction(title: "Enter", style: UIAlertActionStyle.default) { (result) in
            print("TAYLOR: \(alertController.textFields?.first?.text)")
            
            if let userKey = KeychainWrapper.standard.string(forKey: KEY_UID) {
                let refLists = DataService.ds.REF_USERS.child(userKey).child("lists")
                let newListID = refLists.childByAutoId()
                
                if let listName = alertController.textFields?.first?.text {
                    newListID.setValue(["name" : listName], withCompletionBlock: { (error, ref) in
                        if error != nil {
                            print("TAYLOR: unable to push into database \(error)")
                        } else {
                            print("TAYLOR: successfully made it into the database \(ref.key)")
                            DataService.ds.REF_LISTS.child(ref.key).setValue(["name" : listName])
                        }
                    })
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true) { 
            print("TAYLOR: oh hai")
        }
        
    }

}


extension MainListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let list = lists[indexPath.row] as List
        
        print("TAYLOR: ---- table ---- \(list.listName)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        cell.configureCell(listName: list)
        
        return cell
    }
    
}

extension MainListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = lists[indexPath.row] as List
        
        print("TAYLOR: Clicking on List --- \(list.listKey)")
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let viewController = sb.instantiateViewController(withIdentifier: "TaskListVC") as! TaskListVC
        
        viewController.list = list
        
        self.present(viewController, animated: true, completion: nil)

    }
    
}








