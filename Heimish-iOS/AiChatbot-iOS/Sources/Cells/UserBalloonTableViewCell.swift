//
//  UserBalloonTableViewCell.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/03/28.
//

import UIKit

class UserBalloonTableViewCell: UITableViewCell {

    @IBOutlet weak var balloonView: UIView!{
        didSet{
            balloonView.makeRounded(cornerRadius: balloonView.frame.height/4)
        }
    }
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {
            return UINib(nibName: "UserBalloonTableViewCell", bundle: nil)
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
