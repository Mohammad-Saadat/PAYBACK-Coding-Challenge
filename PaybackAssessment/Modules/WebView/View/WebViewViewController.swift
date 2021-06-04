//
//  WebViewViewController.swift
//  TRB
//
//  Created by Farzad on 8/19/20.
//  Copyright (c) 2020 RoundTableApps. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewDisplayLogic: class {
    func displayWebViewPage(viewModel: WebView.SetupWebKit.ViewModel)
    func displayPageTitle(viewModel: WebView.SetupWebKit.ViewModel)
}

class WebViewViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("WebViewViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: WebViewFactory) {
        super.init(nibName: WebViewViewController.nibName, bundle: nil)
        self.factory = factory
        factory.setup(viewController: self)
        WebViewLogger.logInit(owner: String(describing: WebViewViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        WebViewLogger.logDeinit(owner: String(describing: WebViewViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private var factory: WebViewFactory!
    
    // MARK: Public
    var interactor: WebViewBusinessLogic?
    var router: (NSObjectProtocol & WebViewRoutingLogic & WebViewDataPassing)?
    
    // MARK: - Outlets
    
    // MARK: Private
    @IBOutlet private weak var webKit: WKWebView! {
        didSet {
            webKit.navigationDelegate = self
        }
    }
    @IBOutlet private weak var doneContainerView: UIView!
    @IBOutlet private weak var doneButton: UIButton!
}

// MARK: - View Controller

// MARK: Life Cycle
extension WebViewViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        factory.setup(viewController: self)
        interactor?.viewDidLoad(request: WebView.SetupWebKit.Request())
        setColor()
    }
}

// MARK: - Methods

// MARK: Private
private extension WebViewViewController {
    // Setup
    func setup() {
        guard self.interactor == nil else { return }
        let viewController = self
        let interactor = WebViewInteractor()
        let presenter = WebViewPresenter()
        let router = WebViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.webViewController = viewController
        router.dataStore = interactor
    }
}

// MARK: Public
extension WebViewViewController {}

// MARK: - Display Logic
extension WebViewViewController: WebViewDisplayLogic {
    func displayPageTitle(viewModel: WebView.SetupWebKit.ViewModel) {
        self.title = viewModel.pageTitle
    }
    
    func displayWebViewPage(viewModel: WebView.SetupWebKit.ViewModel) {
        let url = viewModel.url
        webKit.load(URLRequest(url: url))
    }
}

// ===============
// MARK: - Web Kit
// ===============

// MARK: Delegate
extension WebViewViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webKit.hideLoading()
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Set the indicator everytime webView started loading
        self.webKit.showLoading()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.webKit.hideLoading()
    }
}

// ===============
// MARK: - Actions
// ===============
extension WebViewViewController {
    @IBAction private func doneBtnTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Appearance
extension WebViewViewController {
    func setColor() {
        self.webKit.backgroundColor = .white
        self.webKit.scrollView.backgroundColor = .white
        self.view.backgroundColor = .white
        self.doneContainerView.backgroundColor = .white
    }
}
