//
//  TableViewCell.swift
//  WongnaiAssignment
//
//  Created by Nuan on 21/11/2562 BE.
//  Copyright © 2562 Hathairat. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var voteImage: UIImageView!
    @IBOutlet weak var voteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
