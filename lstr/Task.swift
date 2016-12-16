//
//  Task.swift
//  lstr
//
//  Created by Taylor King on 12/14/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import Foundation

class Task {
    
    private var _taskName: String!
    private var _completed: Bool!
    private var _taskKey: String!
    
    var taskName: String {
        return _taskName
    }
    
    var completed: Bool {
        return _completed
    }
    
    var taskKey: String {
        get {
            return _taskKey
        }
        
        set(taskKey) {
            self._taskKey = taskKey
        }
    }
    
    init(taskName: String, completed: Bool, taskKey: String) {
        self._taskName = taskName
        self._completed = completed
        self._taskKey = taskKey
    }
    
    func toAnyObject() -> Any {
        return [
            "name": _taskName,
            "completed": _completed
        ]
    }
    
}
