# MathWalletSDK-iOS

#### 基于 SimpleWallet 协议的 iOS SDK
#### 支持公链 ETH,EOS 等


## 如何使用？

### 1、配置URL Schemes
#### Xcode工程info.plist-> URL types -> URL Schemes
![URL Schemes](https://github.com/MathWallet/MathWallet5SDK-iOS/blob/master/urlschemes.jpeg "URL Schemes")

### 2、注册URL Schemes和处理URL

```Swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // MathWalletAPI Register
        MathWalletAPI.default.registerURLSchemes("mathwallet5demos", host: "demos.com")
    }
    ...

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let context = URLContexts.first else { return }
        MathWalletAPI.default.handleOpenURLContext(context)
    }
}
```

### 3、公链，dapp信息

```Swift
    // Chain( Ethereum = 1, BSC = 56, ... )
    let chain = Chain(type: "EVM", id: "1")

    // DApp
    let dapp = DApp(name: "MathWallet5 Demos", icon: "https://staticcdn2.maiziqianbao.net/static/img/project/1.jpg")
```

### 4、使用MathWallet进行登录操作

```Swift
    let data:[String: Any] = [:]
    let req = MathWalletReq(chain: chain, dapp: dapp, action: .login, data: data)
    MathWalletAPI.default.sendReq(req) { (resp: MathWalletResq) in
        ...
    }
```

### 5、使用MathWallet进行转账操作

```Swift
    let data:[String: Any] = [
        "from":"0x306Bb8081C7dD356eA951795Ce4072e6e4bFdC32",
        "to":"0x306Bb8081C7dD356eA951795Ce4072e6e4bFdC32",
        "value":"0x5af3107a4000",
        "data":"0x"
    ]
    let req = MathWalletReq(chain: chain, dapp: dapp, action: .transaction, data: data)
    MathWalletAPI.default.sendReq(req) { (resp: MathWalletResq) in
        ...
    }
```

 ### 6、使用 MathWallet 签名消息

```Swift
    let data:[String: Any] = [
        "address":"0x306Bb8081C7dD356eA951795Ce4072e6e4bFdC32",
        "message":"hello world"
    ]
    let req = MathWalletReq(chain: chain, dapp: dapp, action: .signMessage, data: data)
    MathWalletAPI.default.sendReq(req) { (resp: MathWalletResq) in
        ...
    }
```
 ### 7、使用MathWallet 打开DApp

```Swift
    let data:[String: Any] = [
        "link":"https://www.mathwallet.org"
    ]
    let req = MathWalletReq(chain: chain, dapp: dapp, action: .openURL, data: data)
    MathWalletAPI.default.sendReq(req) { (resp: MathWalletResq) in
        ...
    }
```
