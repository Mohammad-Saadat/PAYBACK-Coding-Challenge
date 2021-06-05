//
//  ShopListViewController.swift
//  PaybackAssessment
//
//  Created by mohammadSaadat on 3/14/1400 AP.
//  Copyright (c) 1400 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ShopListDisplayLogic: class {
    func displayError(viewModel: ShopList.ErrorModel.ViewModel)
    func showLoading()
    func hideLoading()
    func displayData(viewModel: ShopList.Add.ViewModel)
}

class ShopListViewController: KeyboardHandlerViewController {
    // MARK: - Object lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("ShopListViewController - Initialization using coder Not Allowed.")
    }
    
    init(factory: ShopListFactory) {
        super.init(nibName: ShopListViewController.nibName, bundle: nil)
        self.factory = factory
        factory.setup(viewController: self)
        ShopListLogger.logInit(owner: String(describing: ShopListViewController.self))
    }
    
    // MARK: - Deinit
    deinit {
        ShopListLogger.logDeinit(owner: String(describing: ShopListViewController.self))
    }
    
    // MARK: - Properties
    
    // MARK: Private
    private var factory: ShopListFactory!
    
    // MARK: Public
    var interactor: ShopListBusinessLogic?
    var router: (NSObjectProtocol & ShopListRoutingLogic & ShopListDataPassing)?
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(self.plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: DefaultTableView!
    @IBOutlet weak var itemTextField: UITextField! {
        didSet {
            itemTextField.delegate = self
            addRightButton()
        }
    }
    
}

// MARK: - View Controller

// MARK: Life Cycle
extension ShopListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        factory.setup(viewController: self)
        interactor?.fetchItem()
    }
}

// MARK: - Methods

// MARK: Private
private extension ShopListViewController {
    // Setup
    func addRightButton() {
        itemTextField.rightView = rightButton
        itemTextField.rightViewMode = .always
    }
}

// MARK: Public
extension ShopListViewController {
    @objc func plusButtonTapped() {
        guard let itemText = self.itemTextField.text, !itemText.isEmpty else { return }
        itemTextField.text = ""
        interactor?.addToShopList(request: .init(item: itemText))
    }
}

// MARK: - Display Logic
extension ShopListViewController: ShopListDisplayLogic {
    func displayError(viewModel: ShopList.ErrorModel.ViewModel) {
        let action = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        presentMessege(title: "Error",
                       message: viewModel.error.localizedDescription,
                       additionalActions: action,
                       preferredStyle: .alert)
    }
    
    func showLoading() {
        view.showLoading()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    
    func displayData(viewModel: ShopList.Add.ViewModel) {
        let dataSource = DefaultTableViewDataSource(sections: viewModel.sections)
        tableView.displayData(dataSource)
    }
}

// MARK: - Actions
extension ShopListViewController {
    @IBAction func cancelTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ShopListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
