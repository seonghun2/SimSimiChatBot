//
//  ChatManager.swift
//  SimSimi
//
//  Created by user on 2023/02/08.
//

import Foundation
import RxSwift
import Alamofire
import RxRelay

struct ChatManager {
    
    static let shared = ChatManager()
    
    private init() { }
    
    var responseMessage = BehaviorRelay<String>(value: "")
    
    let apiKey = "wQKUqLtth~2TFkvgHJT9d25YW8Tx2ruPtYgb3You"
    
    let baseURL = "https://wsapi.simsimi.com/190410/talk"
    
    func sendMessage(message: String) {
        let headers = HTTPHeaders(["Content-Type": "application/json",
                                       "x-api-key": apiKey])
        
        let parameters = ["utext": message, "lang": "ko"]
        
        AF.request(baseURL, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
            .responseDecodable(of: SimsimiResponse.self) { response in
                print(response)
                response.result.map { response in
                    responseMessage.accept(response.atext!)
                }
            }
    }
}

//curl -X POST https://wsapi.simsimi.com/190410/talk \
//     -H "Content-Type: application/json" \
//     -H "x-api-key: PASTE_YOUR_PROJECT_KEY_HERE" \
//     -d '{
//            "utext": "안녕",
//            "lang": "ko"
//     }'
