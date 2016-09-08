//
//  BabyProfileTableCell.swift
//  SenseALife
//
//  Created by Nadim Bou Zeidan on 12/27/15.
//  Copyright © 2015 BouZeidan. All rights reserved.
//

import UIKit

class BabyProfileTableCell: UITableViewCell {
    
    @IBOutlet weak var BabyImage: UIImageView!
    @IBOutlet weak var FullName: UILabel!
    @IBOutlet weak var SensorID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}