//
//  StorageTableViewCell.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/24.
//

import UIKit

class StorageTableViewCell: UITableViewCell {
    static let identifier = "StorageTableViewCell"
    
    @IBOutlet weak var idxLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emotionView: UIView!{
        didSet{
            emotionView.makeRounded(cornerRadius: 10.0)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
