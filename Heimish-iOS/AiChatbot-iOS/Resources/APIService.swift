//
//  APIService.swift
//  AiChatbot-iOS
//
//  Created by 이원석 on 2021/04/13.
//

import Foundation
import Moya

enum APIService {
    case intent(text: String, sessionId: String)
}

extension APIService: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://768a4749f7f9.ngrok.io")!
    }
    
    public var path: String {
        switch self {
        case .intent: return "/message"
        }
    }
    
    public var task: Task {
        switch self {
        case let .intent(text, sessionId):
            return .requestParameters(parameters: ["text": text, "sessionId": sessionId], encoding: JSONEncoding.default)
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .intent: return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
