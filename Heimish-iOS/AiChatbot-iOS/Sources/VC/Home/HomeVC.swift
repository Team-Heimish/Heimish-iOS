//
//  HomeVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/18.
//

import UIKit
import RealmSwift

class HomeVC: UIViewController {
    let realm = try! Realm()
    
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var startChatBtn: UIButton!{
        didSet{
            startChatBtn.makeRounded(cornerRadius: 15.0)
            startChatBtn.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.4, radius: 3)
        }
    }
    @IBOutlet weak var sunImageView: UIImageView!
    @IBOutlet weak var emotionView: UIView!{
        didSet{
            emotionView.makeRounded(cornerRadius: 15.0)
            emotionView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.4, radius: 3)
        }
    }
    
    @IBOutlet weak var posPgbBackView: UIView!
    @IBOutlet weak var posPgbView: ProgressBarView!
    @IBOutlet weak var posPercentageLabel: UILabel!
    @IBOutlet weak var nagPgbBackView: UIView!
    @IBOutlet weak var nagPgbView: ProgressBarView!
    @IBOutlet weak var nagPercentageLabel: UILabel!
    
    @IBOutlet weak var whatToDoView: UIView!{
        didSet{
            whatToDoView.makeRounded(cornerRadius: 15.0)
            whatToDoView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 4), opacity: 0.4, radius: 3)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtnAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sunAnimation()
        setProgressBar()
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
    
    // MARK: -감정 기록 퍼센트 화
    func setEmotionPercent() -> [Int] {
        var positive = 0
        var nagative = 0
        var total = 0
        realm.objects(Counseiling.self).forEach{
            total += $0.emotion.reduce(0, { $0+$1 })
            positive += ($0.emotion[0]+$0.emotion[1]+$0.emotion[2])
            nagative += ($0.emotion[3]+$0.emotion[4])
        }
        let percentage = (Double(positive)/Double(total)*100)
        
        return [Int(percentage),100-Int(percentage)]
    }
    
    // MARK: -프로그래스바 셋팅
    func setProgressBar(){
        let percentage = setEmotionPercent()
        posPercentageLabel.text = "\(percentage[0])%"
        nagPercentageLabel.text = "\(percentage[1])%"
        posPgbBackView.makeRounded(cornerRadius: posPgbBackView.frame.height/2)
        nagPgbBackView.makeRounded(cornerRadius: nagPgbBackView.frame.height/2)
        customProgressBarView(percentage[0], posPgbView)
        customProgressBarView(percentage[1], nagPgbView)
    }
    
    //MARK: - 프로그래스바 커스텀
    func customProgressBarView(_ value : Int, _ pgbView: ProgressBarView) {
        pgbView.setBackColor(color: .white)
        
        let greenGradient = CAGradientLayer()
        
        // 긍정 게이지
        // frame을 잡아주고
        greenGradient.frame = pgbView.bounds
        // 섞어줄 색을 colors에 넣어준 뒤
        greenGradient.colors = [UIColor.mediumGreen.cgColor,UIColor(red: 0, green: 171/255, blue: 162/255, alpha: 1.0).cgColor]
        greenGradient.startPoint = CGPoint(x: 0, y: 0)
        greenGradient.endPoint = CGPoint(x: 1, y: 0)
        
        // 부정 게이지
        let redGradient = CAGradientLayer()
        redGradient.frame = pgbView.bounds
        redGradient.colors = [UIColor.mainOrange.cgColor,UIColor(red: 171/255, green: 0/255, blue: 23/255, alpha: 1.0).cgColor]
        redGradient.startPoint = CGPoint(x: 0, y: 0)
        redGradient.endPoint = CGPoint(x: 1, y: 0)
        
        if pgbView == posPgbView {
            pgbView.setProgressColor(color: greenGradient)
        }
        else {
            pgbView.setProgressColor(color: redGradient)
        }
        pgbView.setProgressValue(currentValue: CGFloat(value))
    }
    
    // MARK: -상담일지 보러 가기
    @IBAction func goToStorage(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Storage", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "StorageVC") as? StorageVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: -상담 시작하기
    @IBAction func startChat(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        if let vc = storyBoard.instantiateViewController(identifier: "ChatVC") as? ChatVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
