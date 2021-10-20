//
//  Dictionary+JSON.swift
//  MathWallet5SDK-iOS
//
//  Created by math on 2021/10/19.
//

import Foundation

extension Dictionary {
    func toJsonString() -> String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
}

