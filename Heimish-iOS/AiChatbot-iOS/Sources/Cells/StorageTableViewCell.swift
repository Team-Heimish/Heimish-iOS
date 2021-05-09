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
            emotionView.dropShadow(color: .hemishGray, offSet: CGSize(width: 0, height: 4), opacity: 0.4, radius: 3)
        }
    }
    @IBOutlet weak var entryBtn: UIButton!{
        didSet{
            entryBtn.roundCorners(cornerRadius: 10.0, maskedCorners:[ .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        }
    }
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var smileLabel: UILabel!
    @IBOutlet weak var sosoLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var depressedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
