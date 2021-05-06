//
//  StorageVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/24.
//

import UIKit
import RealmSwift

class StorageVC: UIViewController {
    // Realm 가져오기
    let realm = try! Realm()
    
    @IBOutlet weak var counseilingTV: UITableView!{
        didSet{
            counseilingTV.delegate = self
            counseilingTV.dataSource = self
            counseilingTV.separatorStyle = .none // 경계선 제거
            counseilingTV.contentInset = UIEdgeInsets(top: 10,left: 0,bottom: 10,right: 0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm.objects(Counseiling.self))
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension StorageVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let savedChat = realm.objects(Counseiling.self)
        return savedChat.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StorageTableViewCell", for: indexPath) as! StorageTableViewCell
        
        // Realm 데이터 불러오기
        let chatModel = realm.objects(Counseiling.self)
        cell.idxLabel.text = "[\(chatModel[indexPath.row].idx)]"
        cell.dateLabel.text = chatModel[indexPath.row].date
        cell.happyLabel.text = "\(chatModel[indexPath.row].emotion[0])"
        cell.smileLabel.text = "\(chatModel[indexPath.row].emotion[1])"
        cell.sosoLabel.text = "\(chatModel[indexPath.row].emotion[2])"
        cell.sadLabel.text = "\(chatModel[indexPath.row].emotion[3])"
        cell.depressedLabel.text = "\(chatModel[indexPath.row].emotion[4])"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(identifier: "StorageChatVC") as? StorageChatVC {
            self.navigationController?.pushViewController(vc, animated: true)
            vc.chat = realm.objects(Counseiling.self)[indexPath.row].chat
            vc.date = realm.objects(Counseiling.self)[indexPath.row].date
        }
    }

}
