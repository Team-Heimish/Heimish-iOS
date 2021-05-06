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
    var thisidx: Int?
    var chat = List<Content>()
    var date: String?
    @IBOutlet weak var chatTV: UITableView!{
        didSet{
            chatTV.delegate = self
            chatTV.dataSource = self
            chatTV.separatorStyle = .none // 경계선 제거
            chatTV.backgroundColor = .nariYellow
        }
    }
    @IBOutlet weak var dateLabel: UILabel!{
        didSet{
            dateLabel.text = date
        }
    }
    @IBOutlet weak var naviView: UIView!{
        didSet{
            naviView.dropShadow(color: .orange, offSet: CGSize(width: 0, height: 5), opacity: 0.2, radius: 3)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNib()
    }
    
    //Nib 등록
    func setNib() {
        chatTV.register(UINib(nibName: "UserBalloonTableViewCell", bundle:nil), forCellReuseIdentifier:"UserBalloonTableViewCell")
        chatTV.register(UINib(nibName: "AiBalloonTableViewCell", bundle:nil), forCellReuseIdentifier:"AiBalloonTableViewCell")
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func deleteAction(_ sender: Any) {
        if  let thisChat = realm.objects(Counseiling.self).filter("idx = \(thisidx ?? -1)").first {
            try! realm.write {
                realm.delete(thisChat)
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            print("지우려는 상담의 인덱스가 없어요")
        }
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
            userCell.timeLabel.text = chat[indexPath.row].time
            userCell.selectionStyle = .none
            return userCell
        }else if chat[indexPath.row].sender == "chatbot" {
            aiCell.messageLabel.text = chat[indexPath.row].message
            aiCell.timeLabel.text = chat[indexPath.row].time
            aiCell.selectionStyle = .none
            return aiCell
        }
        
        return UITableViewCell()
    }
}
