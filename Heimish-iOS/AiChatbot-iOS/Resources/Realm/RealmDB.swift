//
//  RealmDB.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/24.
//

import Foundation
import RealmSwift

class Counseiling: Object {
    @objc dynamic var idx = 0
    @objc dynamic var date: String = ""
    let emotion: List<Int> = List<Int>()
    var emotionArray: [Int] {
        get {
            return emotion.map{$0}
        }
        set {
            emotion.removeAll()
            emotion.append(objectsIn: newValue)
        }
    }
    var chat = List<Content>()
    
    // id 가 고유 값입니다.
    override static func primaryKey() -> String? {
        return "idx"
    }
}

class Content: Object {
    @objc dynamic var sender :String = ""
    @objc dynamic var message :String = ""
    @objc dynamic var time :String = ""
    let counseiling = LinkingObjects(fromType: Counseiling.self, property: "chat")
}
