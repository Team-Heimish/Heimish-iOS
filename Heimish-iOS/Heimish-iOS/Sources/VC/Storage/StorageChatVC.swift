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
        if  let thisChat = realm?.objects(Counseiling.self).filter("idx = \(thisidx ?? -1)").first {
            try? realm?.write {
                realm?.delete(thisChat)
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            print("지우려는 상담의 인덱스가 없어요")
        }
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
        fpc = FloatingPanelController(delegate: self)
        fpc.layout = MyFloatingPanelLayout()
        fpc.invalidateLayout() // if needed
    }
    
    // Nib 등록
    private func setNib() {
        chatTV.register(UINib(nibName: "UserBalloonTableViewCell", bundle: nil), forCellReuseIdentifier: "UserBalloonTableViewCell")
        chatTV.register(UINib(nibName: "AiBalloonTableViewCell", bundle: nil), forCellReuseIdentifier: "AiBalloonTableViewCell")
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
    func floatingPanel(_ vc: FloatingPanelController, layoutFor size: CGSize) -> FloatingPanelLayout {
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
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] { // 가능한 floating panel: 현재 full, half만 가능하게 설정
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}
