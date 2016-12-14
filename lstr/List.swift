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
    
    var listName: String {
        return _listName
    }
    
    init(name: String) {
        self._listName = name
    }
    
}
