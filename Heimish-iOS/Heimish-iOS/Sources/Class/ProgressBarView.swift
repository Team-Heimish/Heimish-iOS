//
//  ProgressBarView.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/05/08.
//
import UIKit

enum GradationView { case pos, nag }

class ProgressBarView: UIView {
    private let progressLayer = CALayer()
    var kindOf: GradationView = .pos
    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay()} // Property Observer, 값 변경시마다 호출
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.addSublayer(progressLayer)
    }
    
    override func draw(_ rect: CGRect) {
        // 프로그래스 바 back 부분
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.5).cgPath
        layer.mask = backgroundMask
        
        // 프로그래스 바
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width*progress, height: rect.height))
        let progressLayer = CALayer()
        progressLayer.frame = progressRect
        layer.sublayers = nil // 값이 변경되었다면 이전 layer 삭제 후 다시 add
        layer.addSublayer(progressLayer)
        
        let setGradient = CAGradientLayer()
        setGradient.frame = progressLayer.bounds // frame을 잡아주고
        
        // 섞어줄 색 지정
        switch kindOf {
        case .pos: // 긍정
            setGradient.colors = [UIColor.mediumGreen.cgColor, UIColor(red: 0, green: 171/255, blue: 162/255, alpha: 1.0).cgColor]
        case .nag: // 부정
            setGradient.colors = [UIColor.mainOrange.cgColor, UIColor(red: 171/255, green: 0/255, blue: 23/255, alpha: 1.0).cgColor]
        }
        
        setGradient.startPoint = CGPoint(x: 0, y: 0) // 시작점과 끝 지점을 지정
        setGradient.endPoint = CGPoint(x: 1, y: 0)
        setGradient.cornerRadius = rect.height*0.5 // 그라데이션 layer CornerRadius
        progressLayer.cornerRadius = rect.height * 0.5 // 프로그래스바 layer CornerRadius
        progressLayer.addSublayer(setGradient)
    }
}
