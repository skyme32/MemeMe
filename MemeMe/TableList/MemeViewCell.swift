//
//  MemeViewCell.swift
//  MemeMe
//
//  Created by skyme32 on 10/12/21.
//

import UIKit

class MemeViewCell: UITableViewCell {
    
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
