//
//  String+Extend.swift
//  MathWallet5SDK-iOS
//
//  Created by math on 2021/10/19.
//

import Foundation

extension String {
    func toJsonObject() -> AnyObject? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        guard let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            return nil
        }
        return object as AnyObject
    }
}
