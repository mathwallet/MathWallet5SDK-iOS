//
//  TableViewController.swift
//  MathWallet5SDK-iOS
//
//  Created by math on 2021/10/19.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var chainSegmentedControl: UISegmentedControl!
    
    private var selectedChain: Chain = Chain.BSC
    
    private let dapp: DApp = DApp(name: "MathWallet5 Demos", icon: "https://staticcdn2.maiziqianbao.net/static/img/project/1.jpg")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "MathWallet5SDK-iOS"
    }
    
    // MARK: Segmented Control
    @IBAction func chainValueChangedEvent(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedChain = Chain.BSC
        case 1:
            selectedChain = Chain.Solana
        default:
            selectedChain = Chain.Polkadot
        }
    }
    
    
    // MARK: TableView Delegate & DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.loginAction()
            return
        case 1:
            self.transactionAction()
            return
        case 2:
            self.signMessageAction()
            return
        case 3:
            self.openURLAction()
            return
        default:
            break
        }
    }
    
    
    // MARK: Action
    
    func loginAction() {
        let data:[String: Any] = [:]
        let req = MathWalletReq(chain: selectedChain, dapp: dapp, action: .login, data: data)
        MathWalletAPI.default.sendReq(req) { (resp: MathWalletResq) in
            UIAlertController.show(self, title: resp.code.tip, message: resp.code == .success ? resp.result!.toJsonString() : resp.message!)
        }
    }
    
    func transactionAction() {
        var data: [String: Any]
        switch selectedChain.type {
        case "EVM":
            data = [
                "from":"0x306Bb8081C7dD356eA951795Ce4072e6e4bFdC32",
                "to":"0x306Bb8081C7dD356eA951795Ce4072e6e4bFdC32",
                "value":"0x5af3107a4000",
                "data":"0x"
            ]
        case "SOLANA":
            data = [
                "instructions": [
                    "keys": [
                        [
                            "pubkey": "GNutLCXQEEcmxkJH5f5rw51bTW2QcLGXqitmN3EaVPoV",
                            "isSigner": true,
                            "isWritable": true,
                        ]
                    ],
                    "programId": "11111111111111111111111111111111",
                    "data": "0x02000000a086010000000000",
                ]
            ]
        default:
            data = [:]
        }
        let req = MathWalletReq(chain: selectedChain, dapp: dapp, action: .transaction, data: data)
        MathWalletAPI.default.sendReq(req) { (resp: MathWalletResq) in
            UIAlertController.show(self, title: resp.code.tip, message: resp.code == .success ? resp.result!.toJsonString() : resp.message!)
        }
    }
    
    func signMessageAction() {
        let data:[String: Any] = [
            "address":"0x306Bb8081C7dD356eA951795Ce4072e6e4bFdC32",
            "message":"hello world"
        ]
        let req = MathWalletReq(chain: selectedChain, dapp: dapp, action: .signMessage, data: data)
        MathWalletAPI.default.sendReq(req) { (resp: MathWalletResq) in
            UIAlertController.show(self, title: resp.code.tip, message: resp.code == .success ? resp.result!.toJsonString() : resp.message!)
        }
    }
    
    func openURLAction() {
        let data:[String: Any] = [
            "link":"https://mathwallet-public.s3.us-east-2.amazonaws.com/demos/SimpleWallet.html"
        ]
        let req = MathWalletReq(chain: selectedChain, dapp: dapp, action: .openURL, data: data)
        MathWalletAPI.default.sendReq(req) { (resp: MathWalletResq) in
            UIAlertController.show(self, title: resp.code.tip, message: resp.code == .success ? resp.result!.toJsonString() : resp.message!)
        }
    }
}

