//
//  MathWalletAPI.swift
//  MathWallet5SDK-iOS
//
//  Created by math on 2021/10/19.
//

import Foundation
import UIKit

struct MathWalletAPI {
    typealias MathWalletResqBlock = (MathWalletResq) -> Void
    
    private var scheme: String = ""
    private var host: String = ""
    
    private var respArray = [(String, MathWalletResqBlock)]()
    
    static var `default` = MathWalletAPI()
    
    mutating func registerURLSchemes(_ scheme: String, host: String = "mathwallet.org") {
        self.scheme = scheme
        self.host = host
    }
    
    func handleOpenURLContext(_ context: UIOpenURLContext) {
        debugPrint(context.url)
        let webpageURL = context.url
        
        // Same Host
        guard webpageURL.host == self.host else {
            return
        }
        // sw
        guard let components = URLComponents(url: webpageURL, resolvingAgainstBaseURL: false), let queryItems = components.queryItems, let queryItem = queryItems.filter({ $0.name == "response" }).first, let jsonString = queryItem.value  else {
            return
        }
        
        debugPrint(jsonString)
        guard let json = jsonString.toJsonObject() as? [String: Any] else {
            return
        }
        
        guard let resp = MathWalletResq(json) else {
            return
        }
        
        guard let resqBlock = respArray.filter({ $0.0 == resp.id}).first?.1 else {
            return
        }
        
        resqBlock(resp)
    }
    
    mutating func sendReq(_ req: MathWalletReq, response: @escaping MathWalletResqBlock) {
     
        var newReqParams = req.toDictionary()
        newReqParams["callback"] = "\(scheme)://\(host)"
        
        guard let jsonString = newReqParams.toJsonString() else {
            return
        }
        // Send
        guard let urlString = "mathwallet5://mathwallet.org?sw=\(jsonString)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        self.respArray.append((req.id, response))
        debugPrint(urlString)
        UIApplication.shared.open(URL(string: urlString)!, options: [:], completionHandler: nil)
    }
    
}
