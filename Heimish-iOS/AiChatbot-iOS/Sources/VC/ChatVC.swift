//
//  ChatVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/03/28.
//

import UIKit
import Moya


class ChatVC: UIViewController {
    
    var chatDatas = [String]() // 대화가 저장되는 배열
    let formatter = DateFormatter()
    var nowTime: String?
    var keyboardStatus: Bool = false
    
    fileprivate var provider = MoyaProvider<APIService>()
    
    //MARK: -IBOutlet
    @IBOutlet weak var chatTV: UITableView!{
        didSet{
            chatTV.delegate = self
            chatTV.dataSource = self
            chatTV.separatorStyle = .none // 경계선 제거
        }
    }
    @IBOutlet weak var inputTextView: UITextView!{
        didSet{
            inputTextView.makeRounded(cornerRadius: 20)
            inputTextView.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            inputTextView.delegate = self 
        }
    }
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var inputBottomContraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNib()
        setNoti()
        self.navigationController?.navigationBar.alpha = 0.1
    }

    
    //MARK: -사용자 정의 함수
    
    //Nib 등록
    func setNib() {
        chatTV.register(UINib(nibName: "UserBalloonTableViewCell", bundle:nil), forCellReuseIdentifier:"UserBalloonTableViewCell")
        chatTV.register(UINib(nibName: "AiBalloonTableViewCell", bundle:nil), forCellReuseIdentifier:"AiBalloonTableViewCell")
    }
    
    @objc func keyboardWillShow(_ sender:Notification){
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let animationDuration = info[ UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        if !keyboardStatus {
            keyboardStatus = true
            print("Show \(keyboardSize)")
            
            // 키보드 올라오는 애니메이션이랑 동일하게 텍스트뷰 올라가게 만들기.
            UIView.animate(withDuration: animationDuration) {
                self.inputBottomContraint.constant += keyboardSize-30
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ sender:Notification){
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
    
    func setNoti(){
        // 키보드 관련 옵저버 설정
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector:
                                                #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        // 제스쳐 add(테이블 뷰에서 터치 간섭을 해결하기 위함)
        chatTV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    ///화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //터치가 있을 시 핸들러 캐치
    @objc func handleTap(sender: UITapGestureRecognizer) {
         if sender.state == .ended {
            self.view.endEditing(true)
         }
         sender.cancelsTouchesInView = false
    }
    
    // 전송버튼
    @IBAction func sendBtnAction(_ sender: Any) {
        provider.request(.intent(text: inputTextView.text, sessionId: "1111")) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let msgData = try JSONDecoder().decode(MessageData.self, from: response.data)
                    print(msgData.message.text)
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
            inputTextView.text = ""
//        // 텍스트뷰에 있는 값이 chatDatas array에 들어가야지.
//        if inputTextView.text != ""{
//            chatDatas.append(inputTextView.text!)
//            inputTextView.text = ""
//        }
//        
//        let lastindexPath = IndexPath(row: chatDatas.count - 1, section: 0)
//        
//        // 방법 1 : chatTableView.reloadData() 리로드는 조금 부자연스럽다.
//        chatTV.insertRows(at: [lastindexPath], with: UITableView.RowAnimation.automatic)
//        
//        // TableView에는 원하는 곳으로 이동하는 함수가 있다. 고로 전송할때마다 최신 대화로 이동.
//        chatTV.scrollToRow(at: lastindexPath, at: UITableView.ScrollPosition.bottom, animated: true)
    }
}


//MARK: -Portocols
extension ChatVC: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        formatter.dateFormat = "hh:mm"
        nowTime = formatter.string(from: Date())
        if indexPath.row % 2 == 0{
            
            let userCell = tableView.dequeueReusableCell(withIdentifier: "UserBalloonTableViewCell", for: indexPath) as! UserBalloonTableViewCell // MyCell 형식으로 사용하기 위해 형변환이 필요하다.
            userCell.messageLabel.text = chatDatas[indexPath.row]   // 버튼 누르면 chatDatas 에 텍스트를 넣을 것이기 때문에 거기서 꺼내오면 되는거다.
            if userCell.timeLabel.text != nowTime{
                userCell.timeLabel.text = nowTime
                userCell.timeLabel.isHidden = false
            }else{
                userCell.timeLabel.isHidden = true
            }
            userCell.selectionStyle = .none
            return userCell
            
        }
        else{
            
            let aiCell = tableView.dequeueReusableCell(withIdentifier: "AiBalloonTableViewCell", for: indexPath) as! AiBalloonTableViewCell // 이것도 마찬가지.
            aiCell.messageLabel.text = chatDatas[indexPath.row]
            if aiCell.timeLabel.text != nowTime{
                aiCell.timeLabel.text = nowTime
                aiCell.timeLabel.isHidden = false
            }else{
                aiCell.timeLabel.isHidden = true
            }
            
            aiCell.selectionStyle = .none
            return aiCell
            
        }
    }
}
