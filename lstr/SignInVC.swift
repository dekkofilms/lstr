//
//  SignInVC.swift
//  lstr
//
//  Created by Taylor King on 12/12/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    
    @IBOutlet weak var emailField: SingleBorderBottom!
    @IBOutlet weak var passwordField: SingleBorderBottom!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInBtnTapped(_ sender: AnyObject) {
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print("TAYLOR: Unable to sign in via Firebase")
                } else {
                    if let user = user {
                        KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    @IBAction func signUpBtnTapped(_ sender: AnyObject) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    

}
