//
//  MyFriendsTableViewCell.swift
//  VK Client
//
//  Created by Мария Коханчик on 07.02.2021.
//

import UIKit

class MyFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    @IBAction func avatarButton(_ sender: Any) {
        self.avatarImageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                    UIView.animate(withDuration: 1.2,
                                   delay: 0.0,
                                   usingSpringWithDamping: 02,
                                   initialSpringVelocity: 0.2,
                                   options: .curveEaseOut,
                                   animations: {
                                    self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                                   },
                                   completion: nil)
            }
}





