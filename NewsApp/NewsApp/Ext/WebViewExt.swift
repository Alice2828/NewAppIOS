//
//  WebViewExt.swift
//  NewsApp
//
//  Created by Lebedeva Alice on 15.12.2021.
//

import Foundation
import SwiftUI
import Combine
import WebKit
import UIKit
import WebViewWarmUper

enum WebViewNavigationAction {
    case backward, forward, reload
}

enum URLType {
    case local, `public`
}

struct WebView: UIViewRepresentable {
    
    var type: URLType
    var url: String?
    @Binding var dynamicHeight: CGFloat
    @Binding var isLoaderVisible: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        //let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        let webView = WKWebViewWarmUper.shared.dequeue()
        webView.scrollView.bounces = false
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = false
        return webView
        
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlValue = url  {
            if let requestUrl = URL(string: urlValue) {
                webView.load(URLRequest(url: requestUrl))
            }
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
                if complete != nil {
                    webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                        DispatchQueue.main.async {
                            if let ht = height{
                                self.parent.dynamicHeight = ht as! CGFloat
                            }
                            self.parent.isLoaderVisible = false
                        }
                    })
                }
            })
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
