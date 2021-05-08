//
//  HomeVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/18.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var titileLabel: UILabel!{
        didSet{
            titileLabel.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.5, radius: 4)
        }
    }
    @IBOutlet weak var startChatBtn: UIButton!{
        didSet{
            startChatBtn.makeRounded(cornerRadius: 15.0)
            startChatBtn.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.4, radius: 3)
        }
    }
    @IBOutlet weak var sunImageView: UIImageView!
    @IBOutlet weak var todayWordView: UIView!{
        didSet{
//            todayWordView.backgroundColor = .none
//            todayWordView.layer.borderColor = UIColor.nariYellow.cgColor
//            todayWordView.layer.borderWidth  = 2.0
            todayWordView.makeRounded(cornerRadius: 15.0)
        }
    }
    
    @IBOutlet weak var hapPgbBackView: UIView!
    @IBOutlet weak var hapPgbView: ProgressBarView!
    @IBOutlet weak var smilePgbBackView: UIView!
    @IBOutlet weak var smilePgbView: ProgressBarView!
    @IBOutlet weak var soPgbBackView: UIView!
    @IBOutlet weak var soPgbView: ProgressBarView!
    @IBOutlet weak var sadPgbBackView: UIView!
    @IBOutlet weak var sadPgbView: ProgressBarView!
    @IBOutlet weak var depPgbBackView: UIView!
    @IBOutlet weak var depPgbView: ProgressBarView!
    
    @IBOutlet weak var yourEmotionView: UIView!{
        didSet{
            yourEmotionView.makeRounded(cornerRadius: 15.0)
            yourEmotionView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.4, radius: 3)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtnAnimation()
        setProgressBar()
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
    
    func setProgressBar(){
        hapPgbBackView.makeRounded(cornerRadius: hapPgbBackView.frame.height/2)
        smilePgbBackView.makeRounded(cornerRadius: hapPgbBackView.frame.height/2)
        soPgbBackView.makeRounded(cornerRadius: hapPgbBackView.frame.height/2)
        sadPgbBackView.makeRounded(cornerRadius: hapPgbBackView.frame.height/2)
        depPgbBackView.makeRounded(cornerRadius: hapPgbBackView.frame.height/2)
        customProgressBarView(20, hapPgbView)
        customProgressBarView(40, smilePgbView)
        customProgressBarView(60, soPgbView)
        customProgressBarView(80, sadPgbView)
        customProgressBarView(100, depPgbView)
    }
    
    //MARK: - 프로그래스바 커스텀
    func customProgressBarView(_ value : Int, _ pgbView: ProgressBarView) {
        pgbView.setBackColor(color: .white)

        let greenGradient = CAGradientLayer()

        // frame을 잡아주고
        greenGradient.frame = pgbView.bounds

        // 섞어줄 색을 colors에 넣어준 뒤
        greenGradient.colors = [UIColor.deepGreen.cgColor,UIColor(red: 0, green: 171/255, blue: 162/255, alpha: 1.0).cgColor]

        greenGradient.startPoint = CGPoint(x: 0, y: 0)
        greenGradient.endPoint = CGPoint(x: 1, y: 0)

        let redGradient = CAGradientLayer()

        // frame을 잡아주고
        redGradient.frame = pgbView.bounds

        // 섞어줄 색을 colors에 넣어준 뒤
        redGradient.colors = [UIColor.mainOrange.cgColor,UIColor(red: 171/255, green: 0/255, blue: 23/255, alpha: 1.0).cgColor]

        redGradient.startPoint = CGPoint(x: 0, y: 0)
        redGradient.endPoint = CGPoint(x: 1, y: 0)

        if value < 50 {
            pgbView.setProgressColor(color: redGradient)
        }
        else {
            pgbView.setProgressColor(color: greenGradient)
        }
        pgbView
            .setProgressValue(currentValue: CGFloat(value))
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
