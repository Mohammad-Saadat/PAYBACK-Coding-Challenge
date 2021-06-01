//
//  ViewStateManager.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import UIKit

enum ViewStateManagerTheme {
    case dark, light
}

protocol ViewStateManagerView {
    func showLoading()
    func hideLoading()
    var frame: CGRect { get }
    func use(_ view: UIView)
    func dontUse(viewWithTag tag: Int)
}

final class ViewStateManager {
    private init() {}
}

// ====================
// MARK: - Loading View
// ====================
extension ViewStateManager {
    
    static func presentLoadingView<ViewType: UISwitch>(in view: ViewType) {
        view.showLoading()
    }
    
    static func presentLoadingView<ViewType: UITableView>(in view: ViewType) {
        view.showLoading()
    }
    
    static func presentLoadingView<ViewType: UICollectionView>(in view: ViewType) {
        view.showLoading()
    }
    
    static func presentLoadingView<ViewType: ViewStateManagerView>(in view: ViewType) {
        view.showLoading()
    }
    
    static func hideLoadingView<ViewType: UITableView>(from view: ViewType) {
        view.hideLoading()
    }
    
    static func hideLoadingView<ViewType: UICollectionView>(from view: ViewType) {
        view.hideLoading()
    }
    
    static func hideLoadingView<ViewType: ViewStateManagerView>(from view: ViewType) {
        view.hideLoading()
    }
}
