//
//  List.swift
//  lstr
//
//  Created by Taylor King on 12/13/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import Foundation

class List {
    
    private var _listName: String!
    private var _listKey: String!
    
    var listName: String {
        return _listName
    }
    
    var listKey: String {
        return _listKey
    }
    
    init(name: String, key: String) {
        self._listName = name
        self._listKey = key
    }
    
}
