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
        
        let listsRef = DataService.ds.REF_LISTS
        
        listsRef.observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                self.lists = []
                for snap in snapshots {
                    print("TAYLOR: snap ---- \(snap.value)")
                    if let listDict = snap.value as? Dictionary<String, AnyObject> {
                        print("TAYLOR: \(listDict["name"])")
                    }
                    //if let listName = snap["name"] as? String {
                        //print("TAYLOR: \(listName)")
                        //let list = List(name: snap.name)
                    //}
                }
            }
        })
        
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
    

}


extension MainListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let list = lists[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell {
            cell.configureCell(listName: list)
            return cell
        } else {
            return ListCell()
        }
        
    }
    
}

extension MainListVC: UITableViewDelegate {
    
}






