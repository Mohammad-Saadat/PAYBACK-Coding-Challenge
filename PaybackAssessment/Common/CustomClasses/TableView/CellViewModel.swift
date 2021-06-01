//
//  CellViewModel.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation

protocol CellViewModel {
    var nibName: String {get}
    var reuseId: String {get}
    func getModel() -> Any?
    func setModel(model: Any?)
}

protocol Binder {
    func bind(_ viewModel: Any)
}
extension Binder {
    func willDisplay(_ viewModel: Any) { }
}

class DefaultCellViewModel: CellViewModel {
    var nibName: String
    var reuseId: String
    var model: Any?
    
    internal init(nibName: String, reuseId: String, model: Any?) {
        self.nibName = nibName
        self.reuseId = reuseId
        self.model = model
    }
    
    func getModel() -> Any? {
        return model
    }
    
    func setModel(model: Any?) {
        self.model = model
    }
}

class DefaultCollectionTableCellViewModel {}
