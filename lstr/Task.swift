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
    
    var taskName: String {
        return _taskName
    }
    
    var completed: Bool {
        return _completed
    }
    
    init(taskName: String, completed: Bool) {
        self._taskName = taskName
        self._completed = completed
    }
    
    func toAnyObject() -> Any {
        return [
            "name": _taskName,
            "completed": _completed
        ]
    }
    
}
