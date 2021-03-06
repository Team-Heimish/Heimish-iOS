//
//  String+Extension.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/05/09.
//

import UIKit

extension String {
     // 자간 설정
     func wordSpacing(_ spacing: Float) -> NSMutableAttributedString {
         let attributedString = NSMutableAttributedString(string: self)
         attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
         return attributedString
     }

     // 자간, 행간 지정
     // 앱 내 모든 자간 -0.6으로 통일, 행간은 Int값으로 지정 가능
     func textSpacing(lineSpacing: Int) -> NSMutableAttributedString {
         let attributedString = NSMutableAttributedString(string: self)
         let paragraphStyle = NSMutableParagraphStyle()

         paragraphStyle.lineSpacing = CGFloat(lineSpacing)
         attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
         attributedString.addAttribute(NSAttributedString.Key.kern, value: -0.6, range: NSRange(location: 0, length: attributedString.length))

         return attributedString
     }
 }
