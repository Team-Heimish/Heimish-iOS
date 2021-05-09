//
//  EmotionVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/05/04.
//

import UIKit

class EmotionVC: UIViewController {
    
    @IBOutlet weak var emotionPopUpView: UIView!{
        didSet{
            emotionPopUpView.makeRounded(cornerRadius: 10.0)
        }
    }
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var smileLabel: UILabel!
    @IBOutlet weak var sosoLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var depressedLabel: UILabel!
    @IBOutlet weak var completeBtn: UIButton!{
        didSet{
            completeBtn.makeRounded(cornerRadius: 15)
        }
    }
    var emotions = [0,0,0,0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func resetCountAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        let okAction = UIAlertAction(title: "확인", style: .default) { [self] (action) in
           emotions = [0,0,0,0,0]
            happyLabel.text = "\(emotions[0])"
            smileLabel.text = "\(emotions[1])"
            sosoLabel.text = "\(emotions[2])"
            sadLabel.text = "\(emotions[3])"
            depressedLabel.text = "\(emotions[4])"
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    
    @IBAction func resetCount(_ sender: Any) {
        resetCountAlert(title: "감정을 다시 기록하시겠어요?", message: "0부터 다시 선택하게 돼요!")
    }
    @IBAction func clickHappy(_ sender: Any) {
        emotions[0] += 1
        happyLabel.text = "\(emotions[0])"
    }
    @IBAction func clickSmile(_ sender: Any) {
        emotions[1] += 1
        smileLabel.text = "\(emotions[1])"
    }
    @IBAction func clickSoSo(_ sender: Any) {
        emotions[2] += 1
        sosoLabel.text = "\(emotions[2])"
    }
    @IBAction func clickSad(_ sender: Any) {
        emotions[3] += 1
        sadLabel.text = "\(emotions[3])"
    }
    @IBAction func clickDepressed(_ sender: Any) {
        emotions[4] += 1
        depressedLabel.text = "\(emotions[4])"
    }
    
    @IBAction func recordEmotion(_ sender: Any) {
        if let preVC = self.presentingViewController as? UINavigationController{
            if let topVC = preVC.topViewController as? ChatVC{
                topVC.emotionDatas = emotions
                self.presentingViewController?.dismiss(animated: true, completion: {
                    NotificationCenter.default.post(name: NSNotification.Name("recordChat"), object: nil)
                })
            }
        }
    }
}
