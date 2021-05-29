//
//  MessageData.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/13.
//

import Foundation

// MARK: - MessageData
struct MessageData: Codable {
    let status: Int
    let success: Bool
    let message, data: String
}
