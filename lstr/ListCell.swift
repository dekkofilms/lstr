//
//  List.swift
//  lstr
//
//  Created by Taylor King on 12/13/16.
//  Copyright © 2016 Taylor King. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    
    @IBOutlet weak var listNameField: UILabel!
    
    var newList: List!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(listName: List) {
        self.newList = listName
        self.listNameField.text = newList.listName
    }

}
