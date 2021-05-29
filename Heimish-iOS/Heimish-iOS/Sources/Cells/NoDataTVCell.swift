//
//  NoDataTVCell.swift
//  Heimish-iOS
//
//  Created by Wonseok Lee on 2021/05/29.
//

import UIKit

class NoDataTVCell: UITableViewCell {
    static let identifier = "NoDataTVCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "NoDataTVCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
