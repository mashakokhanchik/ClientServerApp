//
//  NewsTableViewCell.swift
//  VK Client
//
//  Created by Мария Коханчик on 16.02.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet var textNews: UILabel!
    @IBOutlet var photoNews: UIImageView!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var eyeImage: UIImageView!
    @IBOutlet var numberOfViews: UILabel!
    @IBOutlet var likeControl: LikeButtonControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
