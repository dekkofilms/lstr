//
//  TaskCell.swift
//  lstr
//
//  Created by Taylor King on 12/14/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    
    var newTask: Task!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(task: Task) {
        self.newTask = task
        self.taskLabel.text = newTask.taskName
    }
    
    func toggleCompletion(_ cell: TaskCell, toggledCompletion: Bool) {
        if !toggledCompletion {
            //cell.taskLabel?.text = self.taskLabel.text
            cell.taskLabel?.textColor = UIColor.black
        } else {
            //cell.taskLabel?.text = "\u{2714}"
            cell.taskLabel?.textColor = UIColor.gray
        }
    }

}
