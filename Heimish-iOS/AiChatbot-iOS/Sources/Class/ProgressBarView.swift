//
//  ProgressBarView.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/05/08.
//
import UIKit

class ProgressBarView: UIView {
    // MARK: - Private Variables
    private var backgroundImage: UIView!
    private var progressView: UIImageView!
    private let animationDuration: Double = 0.6
    
    // MARK: - Overriden Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initBar()
    }
    
    func intrinsicContentSize() -> CGSize {
        return CGSize(width: frame.size.width, height: frame.size.height)
    }
    // MARK: - Public Methods
    /**
     Initializes the progress bar background and also the progress level view.
     The background is equal to the parent view frame.
     */
    func initBar() {
        // make the container with rounded corners and clear background.
//        self.makeRounded(cornerRadius: nil)
        self.setNeedsLayout()
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
        // background image / this view being the same width and height as the parent doesn't need to round the corners. It will take the parent frame.
//        let backgroundRect = CGRect(x: 0.0, y: 0.0, width: Double(frame.size.width), height: Double(frame.size.height))
//        backgroundImage = UIView(frame: backgroundRect)
//        backgroundImage.clipsToBounds = true
//        backgroundImage.backgroundColor = UIColor.clear
//        addSubview(backgroundImage)
        
        // level of progress
        let progressRect = CGRect(x: 0.0, y: 0.0, width: 0.0, height: self.frame.height)
        progressView = UIImageView(frame: progressRect)
        progressView.makeRounded(cornerRadius: nil)
        progressView.layer.masksToBounds = true
        progressView.backgroundColor = UIColor.blue
        addSubview(progressView)
    }
    
    /**
     Sets the progress level from a value, animated.
     - Parameter currentValue : The value that needs to be displayed as a progress bar.
     - Parameter threshold : Optional. The max percentage that the progress bar will display.
     */
    func setProgressValue(currentValue: CGFloat, threshold: CGFloat = 100.0) {
        let xOffset = ((threshold - currentValue) / threshold) * frame.size.width
        self.progressView.frame.origin.x = 0
        UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.progressView.frame.size.width = self.frame.size.width - xOffset
        }, completion: nil)
    }
    
    /**
     Sets the background color of the progress view.
     This color will be displayed underneath the progress view.
     */
//    func setBackColor(color: UIColor) {
//        backgroundImage.backgroundColor = color
//    }
    /**
     Sets the background color of the progress view.
     This is the color that will display the value you have inserted.
     */
    func setProgressColor(color: CAGradientLayer) {
        progressView.layer.addSublayer(color)
    }
}
