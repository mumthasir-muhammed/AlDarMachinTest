//
//  DetailViewController.swift
//  AlDarMachinTest
//
//  Created by Mumthasir VP on 06/08/24.
//

import Foundation
import WebKit

class DetailViewController: UIViewController, WKUIDelegate {    
    private var webView: WKWebView!
    var webviewUrl: URL?

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = webviewUrl else { return }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
}
