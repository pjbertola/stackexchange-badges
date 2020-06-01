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
        let redirectURI = "https://pjb.com.ar/login_success"
        let clientId = "17994"
    
        //MARK: - Methods
        override func loadView() {
            self.view = webView
            webView.scrollView.bounces = false
        }
        
        override func viewDidLoad() {
            navigationController?.setNavigationBarHidden(true, animated: false)
            webView.navigationDelegate = self

            let baseURL = "https://stackoverflow.com/oauth?client_id=\(clientId)&scope=private_info&redirect_uri=\(redirectURI)"

            if let url = URL(string: baseURL){
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
        override func viewWillDisappear(_ animated: Bool) {
            navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    extension LoginWebViewController: WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                if let url = navigationAction.request.url {
                    print("PJB!!!!!!!! URL: " + url.absoluteString)
                    
                    if url.absoluteString.starts(with: redirectURI) {
                        //get values here
                        decisionHandler(.cancel)
                        navigationController?.popViewController(animated: true)
                        return
                    }
                }
                decisionHandler(.allow)
        }
}
