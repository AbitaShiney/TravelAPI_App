//
//  TableViewCell.swift
//  TravelAPIApp
//
//  Created by Charmi Mehta on 2019-03-18.
//  Copyright © 2019 Abita Shiney. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var toCity: UILabel!
    
    @IBOutlet weak var fromCity: UILabel!
    
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
