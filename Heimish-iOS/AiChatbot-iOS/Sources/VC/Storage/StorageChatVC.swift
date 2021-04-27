//
//  StorageChatVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/24.
//

import UIKit
import RealmSwift

class StorageChatVC: UIViewController {
    let realm = try! Realm()
    var chat = List<Content>()
    var date: String?
    @IBOutlet weak var chatTV: UITableView!{
        didSet{
            chatTV.delegate = self
            chatTV.dataSource = self
            chatTV.separatorStyle = .none // 경계선 제거
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNib()
        setStyle()
    }
    
    //Nib 등록
    func setNib() {
        chatTV.register(UINib(nibName: "UserBalloonTableViewCell", bundle:nil), forCellReuseIdentifier:"UserBalloonTableViewCell")
        chatTV.register(UINib(nibName: "AiBalloonTableViewCell", bundle:nil), forCellReuseIdentifier:"AiBalloonTableViewCell")
    }
    
    func setStyle(){
        dateLabel.text = date
        chatTV.backgroundColor = .nariYellow
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension StorageChatVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let userCell = tableView.dequeueReusableCell(withIdentifier: "UserBalloonTableViewCell", for: indexPath) as! UserBalloonTableViewCell
        let aiCell = tableView.dequeueReusableCell(withIdentifier: "AiBalloonTableViewCell", for: indexPath) as! AiBalloonTableViewCell
        
        if chat[indexPath.row].sender == "user" {
            userCell.messageLabel.text = chat[indexPath.row].message
            userCell.timeLabel.isHidden = true
            userCell.selectionStyle = .none
            return userCell
        }else if chat[indexPath.row].sender == "chatbot" {
            aiCell.messageLabel.text = chat[indexPath.row].message
            aiCell.timeLabel.isHidden = true
            aiCell.selectionStyle = .none
            return aiCell
        }
        
        return UITableViewCell()
    }
}
