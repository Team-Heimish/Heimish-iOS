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
    let realm = try? Realm()
    
    @IBOutlet weak var counseilingTV: UITableView! {
        didSet {
            counseilingTV.delegate = self
            counseilingTV.dataSource = self
            counseilingTV.backgroundColor = .heimishWhite
            counseilingTV.separatorStyle = .none // 경계선 제거
            counseilingTV.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm?.objects(Counseiling.self))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension StorageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let savedChat = realm?.objects(Counseiling.self)
        return savedChat?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StorageTableViewCell", for: indexPath) as? StorageTableViewCell else { return UITableViewCell() }
        
        // Realm 데이터 불러오기
        let chatModel = realm?.objects(Counseiling.self)
        cell.idxLabel.text = "\(chatModel?[indexPath.row].idx ?? 999)"
        cell.dateLabel.text = chatModel?[indexPath.row].date ?? "error"
        cell.happyLabel.text = "\(chatModel?[indexPath.row].emotion[0] ?? 999)"
        cell.smileLabel.text = "\(chatModel?[indexPath.row].emotion[1] ?? 999)"
        cell.sosoLabel.text = "\(chatModel?[indexPath.row].emotion[2] ?? 999)"
        cell.sadLabel.text = "\(chatModel?[indexPath.row].emotion[3] ?? 999)"
        cell.depressedLabel.text = "\(chatModel?[indexPath.row].emotion[4] ?? 999)"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dvc = self.storyboard?.instantiateViewController(identifier: "StorageChatVC") as? StorageChatVC {
            self.navigationController?.pushViewController(dvc, animated: true)
            dvc.thisidx = realm?.objects(Counseiling.self)[indexPath.row].idx
            dvc.chat = realm?.objects(Counseiling.self)[indexPath.row].chat ?? List<Content>()
            dvc.date = realm?.objects(Counseiling.self)[indexPath.row].date
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let thisChat = realm?.objects(Counseiling.self).filter("idx = \(realm?.objects(Counseiling.self)[indexPath.row].idx ?? 999)").first {
                try? realm?.write {
                    realm?.delete(thisChat)
                }
            } else {
                print("지우려는 상담의 인덱스가 없어요")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
