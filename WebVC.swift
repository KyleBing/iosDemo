//
//  WebVC.swift
//  iosDemo
//
//  Created by Kyle on 2017-09-6.
//  Copyright © 2017 KyleBing. All rights reserved.
//

import UIKit

class WebVC: UIViewController, UIWebViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    
    let url = URL(string: "https://kylebing.cn/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.backgroundColor = UIColor.lightGray
        webView.loadRequest(URLRequest(url: url))
        
        let btnHome         = UIBarButtonItem(barButtonSystemItem: .bookmarks,      target: self, action: #selector(loadPage))
        let btnBack         = UIBarButtonItem(barButtonSystemItem: .rewind,         target: self, action: #selector(goBack))
        let btnForward      = UIBarButtonItem(barButtonSystemItem: .fastForward,    target: self, action: #selector(goForward))
        let btnRefresh      = UIBarButtonItem(barButtonSystemItem: .refresh,        target: self, action: #selector(refresh))
        
        navigationItem.rightBarButtonItems = [btnHome, btnForward, btnBack, btnRefresh]
        
    }
    
    
    // MARK: - Method Of Navigation In Webview
    @objc func loadPage(){
        navigationItem.rightBarButtonItem?.title = "Loding"
        webView.loadRequest(URLRequest(url: url))
    }
    
    @objc func refresh() {
        webView.reload()
    }
    
    @objc func goBack() {
        webView.goBack()
    }
    
    @objc func goForward () {
        webView.goForward()
    }

}
