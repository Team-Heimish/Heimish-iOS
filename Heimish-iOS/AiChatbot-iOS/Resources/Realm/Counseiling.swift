//
//  Counseiling.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/24.
//

import Foundation
import RealmSwift

class Counseiling: Object {
    @objc dynamic var date: String = "1996-12-26"
    var emotion = List<Int>()
    var chat = List<Content>()
    
    
    // id 가 고유 값입니다.
    override static func primaryKey() -> String? {
      return "date"
    }
}

class Content: Object {
    @objc dynamic var sender :String = ""
    @objc dynamic var message :String = ""
}
