//
//  MathWalletResp.swift
//  MathWallet5SDK-iOS
//
//  Created by math on 2021/10/19.
//

import Foundation

enum Code: Int {
    case cancel = 0
    case success = 1
    case failed = 2
    
    var tip: String {
        switch self {
        case .cancel:
            return "Cancel"
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
}

struct AccountResult {
    var name: String
    var address: String
}


struct MathWalletResq {
    var id: String
    var code: Code
    var result: [String: Any]?
    var message: String?
    
    init?(_ dictionary: [String: Any]) {
        guard let _id = dictionary["id"] as? String else {
            return nil
        }
        guard let _c = dictionary["code"] as? Int, let _code = Code(rawValue: _c) else {
            return nil
        }
        
        self.id = _id
        self.code = _code
        self.result = dictionary["result"] as? [String: Any]
        self.message = dictionary["message"] as? String
    }
}
