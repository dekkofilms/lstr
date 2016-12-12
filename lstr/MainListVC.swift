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
    
    @IBOutlet weak var testLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        testLbl.text = "booyah"
        
        print("TAYLOR: Hit this function")
        if let user = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("TAYLOR: \(user)")
            if user == "uid" {
                performSegue(withIdentifier: "SignIn", sender: nil)
            }
        }
    }

}

