//
//  RoomTableViewCell.swift
//  Hotel Manzana
//
//  Created by Denis Zubkov on 19/10/2018.
//  Copyright © 2018 Denis Zubkov. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var priceTralingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     }
    
    func updateCell(with roomType: RoomType) {
        shortLabel.text = roomType.shortName
        nameLabel.text = roomType.name
        priceLabel.text = "$ \(roomType.price)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   }

}
