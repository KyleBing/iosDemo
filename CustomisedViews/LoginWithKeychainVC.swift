//
//  LoginWithKeychainVC.swift
//  iosDemo
//
//  Created by Kyle on 2020/3/8.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import UIKit
import LocalAuthentication
import Security


struct Credentials {
    var username: String
    var password: String
}


enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}


class LoginWithKeychainVC: UIViewController {
    
    @IBOutlet weak var display: UITextView!
    
    let server = "kylebing.cn"
    private let context = LAContext()

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonAdd = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addAKeyChainItem))
        let buttonGet = UIBarButtonItem(title: "Get", style: .plain, target: self, action: #selector(getKeychain))
        navigationItem.rightBarButtonItems = [buttonAdd, buttonGet]
    }

    
    // MARK: - User methods
    @objc func addAKeyChainItem () {
        let credentials = Credentials(username: "KyleBing", password: "$1021jfdH")
        let account = credentials.username
        let password = credentials.password.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: server,
                                    kSecValueData as String: password]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            display.text += "save keychain item success: \(credentials)\n"
        } else {
            display.text += "save keychain item error\n"
        }
    }
    
    @objc func getKeychain() {
        var touchError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &touchError){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: "Test LocalAutherization: evaluatePolicay method")
            { (success, error) in
                // 1 success
                if success {
                    DispatchQueue.main.async { [unowned self] in
                        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                                    kSecAttrServer as String: self.server,
                                                    kSecMatchLimit as String: kSecMatchLimitAll,
                                                    kSecReturnAttributes as String: true,
                                                    kSecReturnData as String: true]
                        var item: CFTypeRef?
                        let status = SecItemCopyMatching(query as CFDictionary, &item)
                        guard status != errSecItemNotFound else { print("no password found"); return }
                        guard status == errSecSuccess else { print("seek keychain error"); return }
                        
                        guard let existingItem = item as? [String : Any],
                            let passwordData = existingItem[kSecValueData as String] as? Data,
                            let password = String(data: passwordData, encoding: String.Encoding.utf8),
                            let account = existingItem[kSecAttrAccount as String] as? String
                            else {
                                self.display.text += "wrong password data\n"
                                return
                        }
                        
                        let credentials = Credentials(username: account, password: password)
                        self.display.text += "\(credentials)\n"
                        
                    }
                    
                    // 2 error occured
                } else if let error = error {
                    DispatchQueue.main.async {
                    }
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                }
            }
        }
    }
    
}
