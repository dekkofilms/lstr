//
//  DataService.swift
//  lstr
//
//  Created by Taylor King on 12/12/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class DataService {
    
    static let ds = DataService()

    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_LISTS = DB_BASE.child("lists")
    
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_LISTS: FIRDatabaseReference {
        return _REF_LISTS
    }
    
    func createDatabaseUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
}
