//
//  WebViewController.swift
//  Tamatem Assignment
//
//  Created by Osama Abu Hdba on 31/05/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    /// web View
    let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()

    /// Navigation buttons
    lazy var backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward.circle"), style: .plain, target: self, action: #selector(goBack))
    lazy var forwardButton =  UIBarButtonItem(image: UIImage(systemName: "chevron.forward.circle"), style: .plain, target: self, action: #selector(goForward))
    lazy var reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload))

    /// activity Indicator
    var activityIndicator: UIActivityIndicatorView!

    private let url: URL

    init(url: URL, title: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        buttonsConfiguration()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        /// Observe changes to canGoBack and canGoForward properties
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        /// Remove observers
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

    // MARK: - Private Methods
    private func setupWebView() {
        view.backgroundColor = .background
        view.addSubview(webView)
        webView.navigationDelegate = self

        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityIndicator)

        webView.load(URLRequest(url: url))
    }

    private func buttonsConfiguration() {
        [backButton, forwardButton, reloadButton].forEach {
            $0.tintColor = .white
        }

        backButton.isEnabled = false
        navigationItem.rightBarButtonItems = [reloadButton]
        navigationItem.leftBarButtonItems = [backButton, forwardButton]
    }

    private func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self.activityIndicator.stopAnimating()
            })
        } else {
            activityIndicator.stopAnimating()
        }
    }

    // MARK: - Action Methods
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }

    @objc func reload() {
        webView.reload()
        showActivityIndicator(show: false)
    }

    /// Observe changes to if can Go Back and  if  can Go Forward properties 👻
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.canGoBack) {
            backButton.isEnabled = webView.canGoBack
        } else if keyPath == #keyPath(WKWebView.canGoForward) {
            forwardButton.isEnabled = webView.canGoForward
        }
    }
}

// MARK: - WKNavigationDelegate Methods
extension WebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        /// this method should called direct after the page loaded but it take about one minute to receive event from page it's work fine on other websites 🥲
        showActivityIndicator(show: false)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
}
