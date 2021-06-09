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
    
    @IBOutlet weak var naviView: UIView!
    @IBOutlet weak var counseilingTV: UITableView! {
        didSet {
            counseilingTV.delegate = self
            counseilingTV.dataSource = self
            counseilingTV.register(NoDataTVCell.nib(), forCellReuseIdentifier: NoDataTVCell.identifier)
            counseilingTV.backgroundColor = .heimishWhite
            counseilingTV.separatorStyle = .none // 경계선 제거
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm?.objects(Counseiling.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        counseilingTV.reloadSections(IndexSet(0...0), with: .fade)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension StorageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let savedChat = realm?.objects(Counseiling.self) {
            if savedChat.count > 0 {
                return savedChat.count
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let savedChat = realm?.objects(Counseiling.self) {
            if savedChat.count > 0 {
                counseilingTV.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
                counseilingTV.isScrollEnabled = true
                return 100
            }
        }
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        counseilingTV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        counseilingTV.isScrollEnabled = false
        return (self.view.frame.height - (44+statusBarHeight))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let savedChat = realm?.objects(Counseiling.self) {
            if savedChat.count > 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "StorageTableViewCell", for: indexPath) as? StorageTVCell else { return UITableViewCell() }
                
                // Realm 데이터 불러오기
                let chatModel = realm?.objects(Counseiling.self)
                cell.idxLabel.text = "\(indexPath.row+1)" // 상담일지 번호
                cell.dateLabel.text = chatModel?[indexPath.row].date ?? "error" // 상담한 날짜
                cell.happyLabel.text = "\(chatModel?[indexPath.row].emotion[0] ?? 999)" // 감정 기록
                cell.smileLabel.text = "\(chatModel?[indexPath.row].emotion[1] ?? 999)"
                cell.sosoLabel.text = "\(chatModel?[indexPath.row].emotion[2] ?? 999)"
                cell.sadLabel.text = "\(chatModel?[indexPath.row].emotion[3] ?? 999)"
                cell.depressedLabel.text = "\(chatModel?[indexPath.row].emotion[4] ?? 999)"
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = true
                return cell
            }
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataTVCell", for: indexPath) as? NoDataTVCell else { return UITableViewCell() }
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "StorageChat", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(identifier: "StorageChatVC") as? StorageChatVC {
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
                    if let savedChat = realm?.objects(Counseiling.self) {
                        if savedChat.count != 0 {
                            // 지워도 데이터가 1개 이상이면 그냥 지우면 됨
                            tableView.deleteRows(at: [indexPath], with: .fade)
                            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
                        } else {
                            // 근데 지웠을 때 데이터가 0개면 상담 시작해보라는 Cell 나와야 해서 Cell Count 1 유지
                            tableView.reloadRows(at: [indexPath], with: .fade)
                        }
                    }
                }
            } else {
                print("지우려는 상담의 인덱스가 없어요")
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
