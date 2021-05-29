//
//  HomeVC.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/18.
//

import UIKit
import RealmSwift

class HomeVC: UIViewController {
    let realm = try? Realm()
    
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var startChatBtn: UIButton!

    @IBOutlet weak var emotionView: UIView!
    @IBOutlet weak var posPgbBackView: UIView!
    @IBOutlet weak var posPgbView: ProgressBarView!
    @IBOutlet weak var posPercentageLabel: UILabel!
    @IBOutlet weak var nagPgbBackView: UIView!
    @IBOutlet weak var nagPgbView: ProgressBarView!
    @IBOutlet weak var nagPercentageLabel: UILabel!
    @IBOutlet weak var activityTitleLabel: UILabel!
    @IBOutlet weak var activityDescLabel: UILabel!
    @IBOutlet weak var emotionSentenceLabel: UILabel!
    @IBOutlet weak var sunView: UIView!
    @IBOutlet weak var whatToDoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navi Bar 숨겨도 스와이프로 뒤로가기 활성화
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setStyle()
        startBtnAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sunAnimation()
        setActivity()
        setProgressBar()
    }
    
    // MARK: - 상담일지 보러 가기
    @IBAction func goToStorage(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Storage", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(identifier: "StorageVC") as? StorageVC {
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    // MARK: - 상담 시작하기
    @IBAction func startChat(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        if let dvc = storyBoard.instantiateViewController(identifier: "ChatVC") as? ChatVC {
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

extension HomeVC {
    
    func setStyle() {
        startChatBtn.makeRounded(cornerRadius: 15.0)
        startChatBtn.dropShadow(color: .lightGreen, offSet: CGSize(width: 0, height: 4), opacity: 1, radius: 5)
        emotionView.makeRounded(cornerRadius: 15.0)
        emotionView.dropShadow(color: .lightGreen, offSet: CGSize(width: 0, height: 4), opacity: 1, radius: 20)
        sunView.makeRounded(cornerRadius: nil)
        sunView.dropShadow(color: .mainOrange, offSet: CGSize(width: 0, height: 4), opacity: 1, radius: 20)
        whatToDoView.makeRounded(cornerRadius: 15.0)
        whatToDoView.dropShadow(color: .nariYellow, offSet: CGSize(width: 0, height: 4), opacity: 1, radius: 50)
    }
    
    // MARK: - 하루 추천 행동
    func setActivity() {
        var percentage = [Int]()
        if realm?.objects(Counseiling.self).count ?? 0 > 0 {
            percentage = setEmotionPercent()
        } else {
            percentage = [0, 0]
        }
        if percentage[1] >= 90 {
            activityTitleLabel.text = "상담 센터 방문"
            activityDescLabel.text = "우울감이 계속해서 지속된다면,\n전문 상담사와의 상담이 꼭 필요합니다"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd"
            let day  = dateFormatter.string(from: Date())
            activityTitleLabel.text = "📌 \(activities[(Int(day) ?? 0)%activities.count].activity ?? "휴식")"
            activityDescLabel.text = activities[(Int(day) ?? 0)%activities.count].description
        }
    }
    
    // MARK: - 애니메이션 관련
    func sunAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.sunView.transform = CGAffineTransform(translationX: 0, y: 5)
        }, completion: { _ in
            UIView.animate(withDuration: 1, animations: {
                self.sunView.transform = CGAffineTransform(translationX: 0, y: -5)
            })
        })
    }
    func startBtnAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.startChatBtn.transform = CGAffineTransform(translationX: 0, y: -20)
        })
    }
    
    // MARK: - 감정 기록 퍼센트 화
    func setEmotionPercent() -> [Int] {
        var positive = 0
        var nagative = 0
        var total = 0
        realm?.objects(Counseiling.self).forEach {
            total += $0.emotion.reduce(0, { $0+$1 })
            positive += ($0.emotion[0]+$0.emotion[1]+$0.emotion[2])
            nagative += ($0.emotion[3]+$0.emotion[4])
        }
        let percentage = (Double(positive)/Double(total)*100)
        
        return [Int(percentage), 100-Int(percentage)]
    }
    
    // MARK: - 감정 기록 퍼센트에 따른 응원의 한마디
    func setSentence(_ postivie: Int, _ nagative: Int) {
        if postivie > nagative {
            emotionSentenceLabel.text = "점점 더 행복해지고 있는 당신을 보니 너무 기뻐요!"
        } else {
            emotionSentenceLabel.text = "내일은 오늘보다 더 기분 좋은 일들로 가득할거에요!"
        }
    }
    
    // MARK: - 프로그래스바 셋팅
    func setProgressBar() {
        var percentage = [Int]()
        if realm?.objects(Counseiling.self).count ?? 0 > 0 {
            percentage = setEmotionPercent()
        } else {
            percentage = [0, 0]
        }
        setSentence(percentage[0], percentage[1])
        posPercentageLabel.text = "\(percentage[0])%"
        nagPercentageLabel.text = "\(percentage[1])%"
        posPgbBackView.makeRounded(cornerRadius: nil)
        nagPgbBackView.makeRounded(cornerRadius: nil)
        customProgressBarView(percentage[0], posPgbView)
        customProgressBarView(percentage[1], nagPgbView)
    }
    
    // MARK: - 프로그래스바 커스텀
    func customProgressBarView(_ value: Int, _ pgbView: ProgressBarView) {
//        pgbView.setBackColor(color: .heimishWhite)
        
        let greenGradient = CAGradientLayer()
        
        // 긍정 게이지
        // frame을 잡아주고
        greenGradient.frame = pgbView.bounds
        // 섞어줄 색 지정
        greenGradient.colors = [UIColor.mediumGreen.cgColor, UIColor(red: 0, green: 171/255, blue: 162/255, alpha: 1.0).cgColor]
        // 시작점과 끝 지점을 지정
        greenGradient.startPoint = CGPoint(x: 0, y: 0)
        greenGradient.endPoint = CGPoint(x: 1, y: 0)
        
        // 부정 게이지
        let redGradient = CAGradientLayer()
        redGradient.frame = pgbView.bounds
        redGradient.colors = [UIColor.mainOrange.cgColor, UIColor(red: 171/255, green: 0/255, blue: 23/255, alpha: 1.0).cgColor]
        redGradient.startPoint = CGPoint(x: 0, y: 0)
        redGradient.endPoint = CGPoint(x: 1, y: 0)
        
        if pgbView == posPgbView {
            pgbView.setProgressColor(color: greenGradient)
        } else {
            pgbView.setProgressColor(color: redGradient)
        }
        pgbView.setProgressValue(currentValue: CGFloat(value))
    }
}
