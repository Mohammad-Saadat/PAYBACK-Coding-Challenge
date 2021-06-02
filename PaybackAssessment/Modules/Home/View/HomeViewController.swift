//
//  HomeViewController.swift
//  PaybackAssessment
//
//  Created by mohammad on 6/2/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    func displayError(viewModel: Home.ErrorModel.ViewModel)
    func hidePullToRefresh()
    func showLoading()
    func hideLoading()
    func displayData(viewModel: Home.Item.ViewModel)
}

class HomeViewController: UIViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("HomeViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: HomeFactory) {
        super.init(nibName: HomeViewController.nibName, bundle: nil)
        self.factory = factory
        self.factory.setup(viewController: self)
        HomeLogger.logInit(owner: String(describing: HomeViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        HomeLogger.logDeinit(owner: String(describing: HomeViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private var factory: HomeFactory!
    
    // pull to refresh
    private lazy var pullToRefresh: UIRefreshControl = {
        let pullToRefresh = UIRefreshControl()
        pullToRefresh.addTarget(self, action: #selector(refreshPage), for: .valueChanged)
        tableView.alwaysBounceVertical = true
        tableView.refreshControl = pullToRefresh
        return pullToRefresh
    }()
    
    // MARK: Public
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: DefaultTableView! {
        didSet {
//            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 85, right: 0)
            tableView.didSelectTableView = { [weak self] (cellViewModel, _) in
//                guard let cellViewModel = cellViewModel as? ItemCellViewModel,
//                      let model = cellViewModel.getModel() as? LaunchData else { return }
//                self?.router?.navigateToDetailViewController(launchId: model.id)
            }
        }
    }
}

// MARK: - View Controller

// MARK: Life Cycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        factory.setup(viewController: self)
//        interactor?.fetchData()
    }
}

// MARK: - Methods

// MARK: Private
private extension HomeViewController {
    // Setup
    @objc func refreshPage() {
        self.pullToRefresh.beginRefreshing()
//        interactor?.refreshPage()
    }
}

// MARK: Public
extension HomeViewController {}

// MARK: - Display Logic
extension HomeViewController: HomeDisplayLogic {
    func displayError(viewModel: Home.ErrorModel.ViewModel) {
        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        presentMessege(title: "Error",
                       message: viewModel.error.localizedDescription,
                       additionalActions: action,
                       preferredStyle: .alert)
    }
    
    func hidePullToRefresh() {
        pullToRefresh.endRefreshing()
    }
    
    func showLoading() {
        view.showLoading()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    
    func displayData(viewModel: Home.Item.ViewModel) {
        let dataSource = DefaultTableViewDataSource(sections: viewModel.sections)
        tableView.displayData(dataSource)
    }
    
}

// MARK: - Actions
extension HomeViewController {}
