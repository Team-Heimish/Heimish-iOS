//
//  HomeVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/18.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var startChatBtn: UIButton!{
        didSet{
            startChatBtn.makeRounded(cornerRadius: 25.0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startChat(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "ChatVC") as? ChatVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
