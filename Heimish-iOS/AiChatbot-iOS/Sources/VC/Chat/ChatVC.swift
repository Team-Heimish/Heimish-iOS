//
//  ChatVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/03/28.
//

import UIKit
import Moya
import RealmSwift

class ChatVC: UIViewController {
    let realm = try? Realm() // Realm 가져오기
    let formatter = DateFormatter()
    var chatDatas = [[String]]() // 대화가 저장되는 배열
    var emotionDatas = [Int]() // 감정 기록 배열
    var emotionMemos: String? // 감정 하소연 문자열
    var nowTime: String?
    var keyboardStatus: Bool = false
    
    fileprivate var provider = MoyaProvider<APIService>()
    
    // MARK: - IBOutlet
    @IBOutlet weak var naviView: UIView! {
        didSet {
            naviView.dropShadow(color: .deepGreen, offSet: CGSize(width: 0, height: 5), opacity: 0.2, radius: 3)
        }
    }
    @IBOutlet weak var chatTV: UITableView! {
        didSet {
            chatTV.delegate = self
            chatTV.dataSource = self
            chatTV.separatorStyle = .none // 경계선 제거
            chatTV.backgroundColor = .lightGreen
        }
    }
    @IBOutlet weak var inputTextView: UITextView! {
        didSet {
            inputTextView.makeRounded(cornerRadius: 5)
            inputTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            inputTextView.delegate = self
        }
    }
    @IBOutlet weak var sendBtn: UIButton! {
        didSet {
            sendBtn.makeRounded(cornerRadius: 5.0)
        }
    }
    @IBOutlet weak var inputBottomContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNib()
        setNoti()
        loadChat()
        // Realm 파일 위치
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    deinit {
        // 노티 메모리에서 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UserDefaults.standard.setValue(chatDatas, forKey: "loadChat") // 채팅화면에서 자의에 의해 뒤로가기 한건 상담이 안끝났다는 뜻. 대화 저장.
    }
    
    @IBAction func backToHome(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetChat(_ sender: Any) {
        if chatDatas.count == 0 {
            normalAlert(title: "초기화 할 수 없어요", message: "Heimish와의 대화를 시작해보세요!")
        } else {
            resetAlert(title: "정말 초기화 하시겠어요?", message: "초기화된 대화는 복구할 수 없어요!")
        }
        
    }
    
    // 상담일지 기록
    @IBAction func finishChat(_ sender: Any) {
        if chatDatas.count == 0 {
            normalAlert(title: "기록할 상담이 없어요", message: "상담이 이루어져야 기록할 수 있어요!")
        } else {
            finishAlert(title: "상담을 기록하시겠어요?", message: "기록된 상담은 \n 모아보기에서 확인 할 수 있어요!")
        }
        
    }
    // 전송버튼
    @IBAction func sendBtnAction(_ sender: Any) {
        formatter.dateFormat = "HH:mm"
        // 텍스트뷰에 있는 값이 chatDatas에 저장
        if inputTextView.text != ""{
            // textView 초기화 위해 messageBox 변수 선언하여 먼저 저장
            let messageBox = self.inputTextView.text
            nowTime = formatter.string(from: Date()) // 사용자가 보낸 메시지 도착 시간
            self.inputTextView.text = ""
            chatDatas.append(["user", messageBox ?? "행복해", nowTime ?? "-"])
            // chatTableView.reloadData() 는 부자연스러워서 scrollToRow를 사용하여 전송할때마다 최신 대화로 이동.
            let lastindexPath = IndexPath(row: chatDatas.count - 1, section: 0)
            self.chatTV.insertRows(at: [lastindexPath], with: UITableView.RowAnimation.automatic)
            self.chatTV.scrollToRow(at: lastindexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            
            // Server: -Dialogflow/message .POST
            provider.request(.intent(text: messageBox ?? "행복해", sessionId: "1111")) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    do {
                        let msgData = try JSONDecoder().decode(MessageData.self, from: response.data)
                        print(msgData.message)
                        self.nowTime = self.formatter.string(from: Date()) // 챗봇이 보낸 메시지 도착 시간
                        self.chatDatas.append(["chatbot", msgData.data, self.nowTime ?? "-"])
                        let lastindexPath = IndexPath(row: self.chatDatas.count - 1, section: 0)
                        // 방법 1 : chatTableView.reloadData() 리로드는 조금 부자연스럽다.
                        self.chatTV.insertRows(at: [lastindexPath], with: UITableView.RowAnimation.automatic)
                        // TableView에는 원하는 곳으로 이동하는 함수가 있다. 고로 전송할때마다 최신 대화로 이동.
                        self.chatTV.scrollToRow(at: lastindexPath, at: UITableView.ScrollPosition.bottom, animated: true)
                        
                    } catch let err {
                        print(err.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension ChatVC {
    // MARK: - 사용자 정의 함수
    // Nib 등록
    func setNib() {
        chatTV.register(UINib(nibName: "UserBalloonTableViewCell", bundle: nil), forCellReuseIdentifier: "UserBalloonTableViewCell")
        chatTV.register(UINib(nibName: "AiBalloonTableViewCell", bundle: nil), forCellReuseIdentifier: "AiBalloonTableViewCell")
    }
    
    func setNoti() {
        // 키보드 관련 옵저버 설정
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        // SceneDelegate 백그라운드 진입시 대화저장
        NotificationCenter.default.addObserver(self, selector: #selector(saveChat), name: NSNotification.Name("saveChat"), object: nil)
        // 제스쳐 add(테이블 뷰에서 터치 간섭을 해결하기 위함)
        chatTV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    // 대화 불러오기
    func loadChat() {
        chatDatas = UserDefaults.standard.array(forKey: "loadChat") as? [[String]] ?? [[String]]()
    }
    
    // 대화 reset Alert
    func resetAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        let okAction = UIAlertAction(title: "확인", style: .default) { [self] _ in
            UserDefaults.standard.removeObject(forKey: "loadChat")
            chatDatas = []
            chatTV.reloadSections(IndexSet(0...0), with: .fade)
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    // 상담 종료 Alert
    func finishAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        let okAction = UIAlertAction(title: "확인", style: .default) { [self] _ in
            NotificationCenter.default.addObserver(self, selector: #selector(recordChat), name: NSNotification.Name("recordChat"), object: nil)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Emotion", bundle: nil)
            if let dvc = storyBoard.instantiateViewController(identifier: "EmotionVC") as? EmotionVC {
                dvc.modalPresentationStyle = .fullScreen
                self.present(dvc, animated: true, completion: nil)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    // 일반 Alert
    func normalAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc func recordChat() {
        formatter.dateFormat = "YYYY년 MM월 dd일"
        let finishTime = formatter.string(from: Date()) // 상담 종료 시각
        let counseiling = Counseiling()
        counseiling.idx = (realm?.objects(Counseiling.self).last?.idx ?? 0) + 1
        counseiling.date = finishTime
        counseiling.emotionArray = emotionDatas
        print(emotionDatas)
        for idx in 0..<chatDatas.count {
            let content = Content(value: ["sender": chatDatas[idx][0], "message": chatDatas[idx][1], "time": chatDatas[idx][2]])
            counseiling.chat.append(content)
        }
        try? realm?.write {
            realm?.add(counseiling)
        }
        UserDefaults.standard.removeObject(forKey: "loadChat")
        chatDatas = []
        chatTV.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    // 터치가 있을 시 핸들러 캐치
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
    
    @objc func saveChat() {
        if chatDatas.count > 0 {
            UserDefaults.standard.setValue(chatDatas, forKey: "loadChat") // chat기록 저장
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let animationDuration = info[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        if !keyboardStatus {
            keyboardStatus = true
            print("Show \(keyboardSize)")
            // 키보드 올라오는 애니메이션이랑 동일하게 텍스트뷰 올라가게 만들기.
            UIView.animate(withDuration: animationDuration) {
                self.inputBottomContraint.constant += keyboardSize-30
                self.chatTV.setContentOffset(CGPoint(x: 0, y: keyboardSize), animated: true)
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let animationDuration = info[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        print(keyboardSize)
        if keyboardStatus {
            keyboardStatus = false
            UIView.animate(withDuration: animationDuration) {
                self.inputBottomContraint.constant -= keyboardSize-30
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - Portocols
extension ChatVC: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if chatDatas[indexPath.row][0] == "user"{
            
            guard let userCell = tableView.dequeueReusableCell(withIdentifier: "UserBalloonTableViewCell", for: indexPath) as? UserBalloonTableViewCell else { return UITableViewCell() }
            userCell.messageLabel.text = chatDatas[indexPath.row][1]
            
            if userCell.timeLabel.text != chatDatas[indexPath.row][2] {
                userCell.timeLabel.text = chatDatas[indexPath.row][2]
                userCell.timeLabel.isHidden = false
            } else {
                userCell.timeLabel.isHidden = true
            }
            userCell.selectionStyle = .none
            return userCell
        } else if chatDatas[indexPath.row][0] == "chatbot"{
            
            guard let aiCell = tableView.dequeueReusableCell(withIdentifier: "AiBalloonTableViewCell", for: indexPath) as? AiBalloonTableViewCell else { return UITableViewCell() }
            aiCell.messageLabel.text = chatDatas[indexPath.row][1]
            if aiCell.timeLabel.text != chatDatas[indexPath.row][2] {
                aiCell.timeLabel.text = chatDatas[indexPath.row][2]
                aiCell.timeLabel.isHidden = false
            } else {
                aiCell.timeLabel.isHidden = true
            }
            aiCell.selectionStyle = .none
            return aiCell
        }
        return UITableViewCell()
    }
}
