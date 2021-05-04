//
//  Counseiling.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/24.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var userId = 0
    var counseilingdate = List<CounseilingDate>()
    
    // userId 가 고유 값입니다.
    override static func primaryKey() -> String? {
      return "userId"
    }
}

class CounseilingDate: Object{
    @objc dynamic var idx = 0
    @objc dynamic var date: String = ""
    var emotion = List<Int>()
    var chat = List<Content>()
    var parentCategory = LinkingObjects(fromType: CounseilingDate.self, property: "counseilingdate")
    
    override static func primaryKey() -> String? {
      return "idx"
    }
}

class Content: Object {
    @objc dynamic var sender :String = ""
    @objc dynamic var message :String = ""
    @objc dynamic var time :String = ""
    var parentCategory = LinkingObjects(fromType: User.self, property: "chat")
}
