//
//  AuthenticationTableVC.swift
//  CustomisedViews
//
//  Created by Kyle on 2020/3/2.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationTableVC: UITableViewController {
    
    // 1. 获取 context
    private let context = LAContext()
    
    private var AuthenticationList = [
        (title: "Biometrics",   description: "", type: LAPolicy.deviceOwnerAuthenticationWithBiometrics),
        (title: "Password",     description: "", type: LAPolicy.deviceOwnerAuthentication)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        context.touchIDAuthenticationAllowableReuseDuration = 10 // 10秒内重复验证，不需要再次验证
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AuthenticationList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthenticationCell", for: indexPath)
        let listItem = AuthenticationList[indexPath.row]
        cell.textLabel?.text = listItem.title
        cell.detailTextLabel?.text = listItem.description
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItem = AuthenticationList[indexPath.row]
        var touchError: NSError?
        // 2. 查看要执行的验证方式是否可用
        if context.canEvaluatePolicy(listItem.type, error: &touchError){
            // 3. 执行验证
            context.evaluatePolicy(listItem.type,
                                   localizedReason: "Test LocalAutherization: evaluatePolicay method")
            { (success, error) in
                // 4.1 success
                if success {
                    DispatchQueue.main.async {
                        self.AuthenticationList[indexPath.row].description = "success"
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                            title: String(format: "%.f", self.context.touchIDAuthenticationAllowableReuseDuration),
                            style: .plain,
                            target: nil,
                            action: nil)
                    }
                    
                // 4.2 error occured
                } else if let error = error {
                    DispatchQueue.main.async {
                        self.AuthenticationList[indexPath.row].description = error.localizedDescription
                    }
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [indexPath], with: .right)
                }
            }
        }
    }
}
