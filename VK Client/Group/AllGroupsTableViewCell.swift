//
//  AllGroupsTableViewCell.swift
//  VK Client
//
//  Created by Мария Коханчик on 07.02.2021.
//

import UIKit

class AllGroupsTableViewCell: UITableViewCell {
    
    @IBOutlet var groupName: UILabel!
    
    @IBOutlet var groupImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
