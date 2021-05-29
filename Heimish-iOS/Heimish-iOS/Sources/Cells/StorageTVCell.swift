//
//  StorageTVCell.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/24.
//

import UIKit

class StorageTVCell: UITableViewCell {
    static let identifier = "StorageTableViewCell"
    
    @IBOutlet weak var idxLabel: UILabel!
    @IBOutlet weak var idxView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var emotionView: UIView!
    @IBOutlet weak var entryBtn: UIButton!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var smileLabel: UILabel!
    @IBOutlet weak var sosoLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var depressedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellStyle()
    }
    
    func setCellStyle() {
        emotionView.makeRounded(cornerRadius: 10.0)
        emotionView.dropShadow(color: .mainOrange, offSet: CGSize(width: 0, height: 4), opacity: 0.4, radius: 3)
        entryBtn.roundCorners(cornerRadius: 10.0, maskedCorners: [ .layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        idxView.roundCorners(cornerRadius: 10.0, maskedCorners: [.layerMinXMinYCorner,.layerMaxXMaxYCorner])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
