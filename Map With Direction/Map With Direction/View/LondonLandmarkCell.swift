//
//  LondonLandmarkCell.swift
//  Map With Direction
//
//  Created by Mac on 9/25/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation
import UIKit

class LondonLandmarkCell: UITableViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var postalCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
