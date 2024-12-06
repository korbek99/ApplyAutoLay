//
//  WebViewController.swift
//  ApplyAutoLay
//
//  Created by Jose Preatorian on 04-12-24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private var routers: RoutingMV?
    var hits: Hit
    private var webView: WKWebView!
    init(hits: Hit) {
        self.hits = hits
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        routers = RoutingMV()
        routers?.assignViewController(self)
        setupWebView()
        loadURL()
    }
    
    private func setupWebView() {
            webView = WKWebView(frame: view.bounds)
            webView.navigationDelegate = self
            webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.addSubview(webView)
    }
 
    private func loadURL() {
        guard let urlString = hits.storyURL, let url = URL(string: urlString) else {
                showErrorAlert()
                return
            }
            let request = URLRequest(url: url)
            webView.load(request)
    }

    private func showErrorAlert() {
        routers?.goToError(error: NSLocalizedString("TABLE_ERROR_URL", comment: "error message"))
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Error al cargar la página: \(error.localizedDescription)")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Carga completada.")
    }
}
