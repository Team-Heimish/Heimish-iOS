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
            startChatBtn.makeRounded(cornerRadius: 25.0)
        }
    }
    @IBOutlet weak var sunImageView: UIImageView!
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
                self.sunImageView.transform = CGAffineTransform(translationX: 0, y: 10)
            }, completion: { _ in
                UIView.animate(withDuration: 1, animations: {
                    self.sunImageView.transform = CGAffineTransform(translationX: 0, y: -10)
                })
            });
    }
    
    func startBtnAnimation(){
        UIView.animate(withDuration: 1, animations: {
                self.startChatBtn.transform = CGAffineTransform(translationX: 0, y: -20)
            })
    }
    
    @IBAction func startChat(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "ChatVC") as? ChatVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
