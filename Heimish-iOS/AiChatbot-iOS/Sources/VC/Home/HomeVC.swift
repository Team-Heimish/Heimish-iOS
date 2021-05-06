//
//  HomeVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/18.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var startChatBtn: UIButton!{
        didSet{
            startChatBtn.makeRounded(cornerRadius: 15.0)
            startChatBtn.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.4, radius: 3)
        }
    }
    @IBOutlet weak var sunImageView: UIImageView!
    @IBOutlet weak var todayWordView: UIView!{
        didSet{
            todayWordView.backgroundColor = .none
            todayWordView.layer.borderColor = UIColor.nariYellow.cgColor
            todayWordView.layer.borderWidth  = 2.0
            todayWordView.makeRounded(cornerRadius: 15.0)
        }
    }
    @IBOutlet weak var yourEmotionView: UIView!{
        didSet{
            yourEmotionView.makeRounded(cornerRadius: 15.0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtnAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sunAnimation()
    }
    
    func sunAnimation(){
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
                self.sunImageView.transform = CGAffineTransform(translationX: 0, y: 5)
            }, completion: { _ in
                UIView.animate(withDuration: 1, animations: {
                    self.sunImageView.transform = CGAffineTransform(translationX: 0, y: -5)
                })
            });
    }
    
    func startBtnAnimation(){
        UIView.animate(withDuration: 1, animations: {
                self.startChatBtn.transform = CGAffineTransform(translationX: 0, y: -20)
        });
    }
    
    @IBAction func goToStorage(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Storage", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "StorageVC") as? StorageVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func startChat(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "ChatVC") as? ChatVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
