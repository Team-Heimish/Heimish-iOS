//
//  StorageChatVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/24.
//

import UIKit
import RealmSwift
import FloatingPanel

class StorageChatVC: UIViewController {
    let realm = try? Realm()
    var fpc: FloatingPanelController!
    var contentsVC: StorageFloatingVC! // 띄울 VC
    var thisidx: Int?
    var chat = List<Content>()
    var date: String?
    
    @IBOutlet weak var chatTV: UITableView! {
        didSet {
            chatTV.delegate = self
            chatTV.dataSource = self
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var naviView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setNib()
        setupFloatingView()
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func deleteAction(_ sender: Any) {
        deleteAlert(title: "상담기록 삭제", message: "상담 기록을 삭제하시겠습니까?")
    }
}

extension StorageChatVC {
    private func setStyle() {
        chatTV.separatorStyle = .none // 경계선 제거
        chatTV.backgroundColor = .lightGreen
        dateLabel.text = date
        naviView.dropShadow(color: .deepGreen, offSet: CGSize(width: 0, height: 5), opacity: 0.2, radius: 3)
    }
    
    private func setupFloatingView() {
        contentsVC = self.storyboard?.instantiateViewController(identifier: "StorageFloatingVC", creator: { (coder) -> StorageFloatingVC? in
            return StorageFloatingVC(coder: coder)
        })
        contentsVC.idx = thisidx!
        fpc = FloatingPanelController()
        fpc.changePanelStyle() // panel 스타일 변경 (대신 bar UI가 사라지므로 따로 넣어주어야함)
        fpc.set(contentViewController: contentsVC) // floating panel에 삽입할 것
        fpc.addPanel(toParent: self) // fpc를 관리하는 UIViewController
        fpc.delegate = self
        fpc.layout = MyFloatingPanelLayout()
        fpc.invalidateLayout() // if needed
    }
    
    // Nib 등록
    private func setNib() {
        chatTV.register(UINib(nibName: "UserBalloonTableViewCell", bundle: nil), forCellReuseIdentifier: "UserBalloonTableViewCell")
        chatTV.register(UINib(nibName: "AiBalloonTableViewCell", bundle: nil), forCellReuseIdentifier: "AiBalloonTableViewCell")
    }
    
    // 삭제 확인 Alert
    private func deleteAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        let okAction = UIAlertAction(title: "확인", style: .default) { [self] _ in
            if  let thisChat = realm?.objects(Counseiling.self).filter("idx = \(thisidx ?? -1)").first {
                try? realm?.write {
                    realm?.delete(thisChat)
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                print("지우려는 상담의 인덱스가 없어요")
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

extension FloatingPanelController {
    func changePanelStyle() {
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: -4.0)
        shadow.opacity = 0.15
        shadow.radius = 2
        appearance.shadows = [shadow]
        appearance.cornerRadius = 15.0
        appearance.backgroundColor = .clear
        appearance.borderColor = .clear
        appearance.borderWidth = 0

        surfaceView.grabberHandle.isHidden = true
        surfaceView.appearance = appearance

    }
}

extension StorageChatVC: FloatingPanelControllerDelegate {
    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return MyFloatingPanelLayout()
    }
}

extension StorageChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let userCell = tableView.dequeueReusableCell(withIdentifier: "UserBalloonTableViewCell", for: indexPath) as? UserBalloonTVCell else { return UITableViewCell() }
        guard let aiCell = tableView.dequeueReusableCell(withIdentifier: "AiBalloonTableViewCell", for: indexPath) as? AiBalloonTVCell else { return UITableViewCell() }
        
        if chat[indexPath.row].sender == "user" {
            userCell.messageLabel.text = chat[indexPath.row].message
            userCell.timeLabel.text = chat[indexPath.row].time
            userCell.selectionStyle = .none
            return userCell
        } else if chat[indexPath.row].sender == "chatbot" {
            aiCell.messageLabel.text = chat[indexPath.row].message
            aiCell.timeLabel.text = chat[indexPath.row].time
            aiCell.selectionStyle = .none
            return aiCell
        }
        
        return UITableViewCell()
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    var layoutBottomInset: CGFloat = 150 // floating panel의 길이 조정 (밑 anchors 변수에 사용)
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: layoutBottomInset, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}
