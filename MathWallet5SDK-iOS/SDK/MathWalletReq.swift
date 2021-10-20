//
//  MathWalletReq.swift
//  MathWallet5SDK-iOS
//
//  Created by math on 2021/10/19.
//

import Foundation

struct Chain {
    var type: String
    var id: String
    
    func toDictionary() -> Dictionary<String, Any> {
        return [
            "type": self.type,
            "id": self.id
        ]
    }
    
    static var Ethereum = Chain(type: "EVM", id: "1")
    static var BSC = Chain(type: "EVM", id: "56")
}

struct DApp {
    var name: String
    var icon: String?
    
    func toDictionary() -> Dictionary<String, Any> {
        return [
            "name": self.name,
            "icon": self.icon ?? ""
        ]
    }
}

enum Action: String {
    case login
    case transaction
    case openURL
    case signMessage
}

struct MathWalletReq {
    var `protocol` = "SimpleWallet"
    var version = "2.0"
    var chain: Chain
    var dapp: DApp
    var action: Action
    var id: String = UUID().uuidString
    var data: [String: Any]
    
    func toDictionary() -> Dictionary<String, Any> {
        return [
            "protocol": self.protocol,
            "version": self.version,
            "chain": self.chain.toDictionary(),
            "dapp": self.dapp.toDictionary(),
            "action": self.action.rawValue,
            "id": self.id,
            "data": self.data
        ]
    }
}
