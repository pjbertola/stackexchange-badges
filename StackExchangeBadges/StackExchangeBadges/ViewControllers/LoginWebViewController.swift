//
//  LoginWebViewController.swift
//  StackExchangeBadges
//
//  Created by Pablo Javier Bertola on 31/05/2020.
//  Copyright © 2020 Pablo Javier Bertola. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class LoginWebViewController: UIViewController {

    //MARK: - Properties
    let webView = WKWebView()

    var repository: StackUserRepository!

    //MARK: - Methods
    override func loadView() {
        self.view = webView
        webView.scrollView.bounces = false
    }
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        webView.navigationDelegate = self
        
        if let url = StackEndpoint.oauth.url{
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

}

//MARK:- WKNavigationDelegate
extension LoginWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                print("PJB!!!!!!!! URL: " + url.absoluteString)
                
                if url.absoluteString.starts(with: StackExchangeApp.redirect.rawValue) {
                    if let code = getCode(from: url.absoluteString) {
                        repository.setLoginCode(code)
                    }
                    decisionHandler(.cancel)
                    navigationController?.popViewController(animated: true)
                    return
                }
            }
            decisionHandler(.allow)
    }
    
    func getCode(from urlStr:String) -> String? {
        let parts = urlStr.split(separator: "&")
        for part in parts {
            if part.contains("code") {
                let codeArray = part.split(separator: "=")
                if let code = codeArray.last{
                    return String(code)
                }
            }
        }
        return nil
    }
}
