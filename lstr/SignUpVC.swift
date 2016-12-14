//
//  SignUpVC.swift
//  lstr
//
//  Created by Taylor King on 12/12/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var usernameField: SingleBorderBottom!
    @IBOutlet weak var emailField: SingleBorderBottom!
    @IBOutlet weak var passwordField: SingleBorderBottom!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtnTapped(_ sender: AnyObject) {
        
        if let email = emailField.text, let password = passwordField.text, let username = usernameField.text {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print("TAYLOR: Unable to create the user")
                } else {
                    if let user = user {
                        let userData = ["provider": user.providerID, "username": username]
                        DataService.ds.createDatabaseUser(uid: user.uid, userData: userData)
                        KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                        self.performSegue(withIdentifier: "goToMainList", sender: nil)
                    }
                    
                }
            })
        }
        
    }
    

}
