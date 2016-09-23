//
//  EventTableViewCell.swift
//  Dinosys_Corp_News
//
//  Created by Hung Nguyen on 9/23/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var dateField: UILabel!
    @IBOutlet var eventName: UILabel!
    @IBOutlet var status: UILabel!
    
    @IBOutlet var decriptionField: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
