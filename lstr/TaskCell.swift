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
            //rgba(153, 108, 93, 1)
            cell.taskLabel?.textColor = UIColor.init(red: 153/255, green: 108/255, blue: 93/255, alpha: 1.0)
        } else {
            //cell.taskLabel?.text = "\u{2714}"
            //rgba(117, 83, 73, 1) dark brown or rgba(229, 115, 115, 1) red
            cell.taskLabel?.textColor = UIColor.init(red: 229/255, green: 115/255, blue: 115/255, alpha: 1.0)
        }
    }

}
