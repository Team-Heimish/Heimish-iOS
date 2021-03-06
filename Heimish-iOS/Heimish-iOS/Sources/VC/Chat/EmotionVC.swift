//
//  EmotionVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/05/04.
//

import UIKit

class EmotionVC: UIViewController {
    var emotions = [0, 0, 0, 0, 0]
    @IBOutlet weak var toggleSwtich: UISwitch!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var smileLabel: UILabel!
    @IBOutlet weak var sosoLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var depressedLabel: UILabel!
    @IBOutlet weak var completeBtn: UIButton!
    @IBOutlet weak var emotionTextView: UITextView! {
        didSet {
            emotionTextView.delegate = self
            emotionTextView.textContainerInset = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRound()
        addGesutre()
        textViewPlaceholder()
    }
    
    @IBAction func swtichTapped(_ sender: Any) {
        if toggleSwtich.isOn {
            self.basicAlert(title: "기록 ON", message: "작성한 속마음을 상담일지에서 열람할 수 있어요!")
        } else {
            self.basicAlert(title: "기록 OFF", message: "상담일지에 작성한 속마음이 기록되지 않아요")
        }
    }
    @IBAction func resetCount(_ sender: Any) {
        emotions = [0, 0, 0, 0, 0]
        happyLabel.text = "\(emotions[0])"
        smileLabel.text = "\(emotions[1])"
        sosoLabel.text = "\(emotions[2])"
        sadLabel.text = "\(emotions[3])"
        depressedLabel.text = "\(emotions[4])"
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
        if toggleSwtich.isOn, let complaining = emotionTextView.text {
            print("적은거 있을때"+complaining)
            if complaining != "얼마든지 적어도 좋아" && emotionTextView.text.count > 0 {
                NotificationCenter.default.post(name: NSNotification.Name("recordChat"), object: [emotions,complaining])
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("recordChat"), object: [emotions])
            }
        } else {
            print("적은거 없을때")
            NotificationCenter.default.post(name: NSNotification.Name("recordChat"), object: [emotions])
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension EmotionVC {
    
    // MARK: - radius 관련
    private func setRound() {
        resetBtn.makeRounded(cornerRadius: 5)
        completeBtn.makeRounded(cornerRadius: 10)
        emotionTextView.makeRounded(cornerRadius: 10)
    }
    
    // MARK: - Gesture
    private func addGesutre() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    private func textViewPlaceholder() {
        if emotionTextView.text == "얼마든지 적어도 좋아" {
            emotionTextView.text = ""
            emotionTextView.textColor = .black
        } else if emotionTextView.text == "" {
            emotionTextView.text = "얼마든지 적어도 좋아"
            emotionTextView.textColor = .lightGray
        }
    }
    
    @objc private func keyboardWillShowEmotion(_ sender: Notification) {
        /// 텍스트 뷰 입력할 때에만 키보드 올리면 됨
        let info = sender.userInfo!
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        if emotionTextView.isFirstResponder {
            UIView.animate(withDuration: 2.0, animations: { [self] in
                self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize)
            })
        }
    }
    
    @objc private func keyboardWillHideEmotion(_ sender: Notification) {
        /// 텍스트 뷰 입력할 때에만 키보드 올리면 됨
        if emotionTextView.isFirstResponder {
            UIView.animate(withDuration: 2.0, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        }
    }
    
    // 터치가 있을 시 핸들러 캐치
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }
}

extension EmotionVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewPlaceholder()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewPlaceholder()
    }
}
