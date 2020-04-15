//
//  EmTableViewCell.swift
//  test2
//
//  Created by  Виталий on 14.04.2020.
//  Copyright © 2020 Bulavin. All rights reserved.
//

import UIKit

class EmTableViewCell: UITableViewCell {
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var lb3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    } 
    func set(object: emoji ) {
    self.lb1.text = object.emoji
    self.lb2.text = object.name
    self.lb3.text = object.description
    }
}
