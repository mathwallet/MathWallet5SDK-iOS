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
    static var Solana = Chain(type: "SOLANA", id: "5eykt4UsFv8P8NJdTREpY1vzqKqZKvdpKuc147dw2N9d")
    static var Polkadot = Chain(type: "SUBSTRATE", id: "0x91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3")
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
