//
//  UITextField+Extension.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/03/28.
//

import Foundation
import UIKit

extension UITextField{
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func addRightPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 111, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}
