//
//  VKLoginViewController.swift
//  VK Client
//
//  Created by Мария Коханчик on 20.03.2021.
//

import UIKit
import WebKit
//import Alamofire

class VKLoginViewController: UIViewController {
    
    @IBOutlet weak var webViwe: WKWebView! {
        didSet {
            webViwe.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7796604"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        
        guard let url = components.url else { return }
        
        let request = URLRequest(url: url)
        webViwe.load(request)
    }
}

extension VKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        print(fragment)
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        print(params)
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let _ = Int(userIdString) else {
            decisionHandler(.allow)
            return
        }
        
        Session.instance.token = token
        
        NetworkManager.shared.loadGroups(token: token)
        NetworkManager.shared.searchGroups(token: token)
        NetworkManager.shared.loadFriends(token: token)
        NetworkManager.shared.loadPhotos(token: token)
        
        decisionHandler(.cancel)
        
    }
}

