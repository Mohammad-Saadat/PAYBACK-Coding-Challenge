//
//  SectionViewModel.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import UIKit

protocol SectionViewModel {
    var cells: [CellViewModel] {get set}

    func getHeaderReuseId() -> String?
    func getHeaderNibName() -> String?
    func getHeaderHeight() -> CGFloat?
    func getHeaderExpanded() -> Bool
    func setHeaderExpanded(value: Bool)
    func getHeaderExpandable() -> Bool
    func getHeaderModel() -> Any?

    func getFooterReuseId() -> String?
    func getFooterNibName() -> String?
    func getFooterHeight() -> CGFloat?
    func getFooterModel() -> Any?

    func appendCells(cells: [CellViewModel])
    func deleteCells(indices: [Int])
    func updateCell(cellIndex: Int, newValue: CellViewModel)
    func insertCell(cell: CellViewModel, at index: IndexPath)
}

extension SectionViewModel {

    func getHeaderReuseId() -> String? {
        return nil
    }

    func getHeaderNibName() -> String? {
        return ""
    }

    func getHeaderHeight() -> CGFloat? {
        return CGFloat.leastNonzeroMagnitude
    }

    func getHeaderModel() -> Any? {
        return nil
    }

    func getFooterReuseId() -> String? {
        return nil
    }

    func getFooterNibName() -> String? {
        return ""
    }

    func getFooterHeight() -> CGFloat? {
        return CGFloat.leastNonzeroMagnitude
    }

    func getFooterModel() -> Any? {
        return nil
    }

}

class DefaultSection: SectionViewModel {
    var cells: [CellViewModel]

    var sectionHeaderReuseId: String?
    var sectionHeaderNibName: String?
    var sectionHeaderHeight: CGFloat?
    var sectionHeaderExpanded: Bool?
    var sectionHeaderExpandable: Bool?
    var sectionHeaderModel: Any?

    var sectionFooterReuseId: String?
    var sectionFooterNibName: String?
    var sectionFooterHeight: CGFloat?
    var sectionFooterModel: Any?

    init(cells: [CellViewModel]) {
        self.cells = cells
    }

    func setHeaderValues(_ reuseId: String?, nibName: String, height: CGFloat, model: Any?, isExpandable: Bool? = false, isExpanded: Bool? = true) {
        self.sectionHeaderModel = model
        self.sectionHeaderHeight = height
        self.sectionHeaderReuseId = reuseId
        self.sectionHeaderNibName = nibName
        if let isExpandable = isExpandable {
            self.sectionHeaderExpandable = isExpandable
            self.sectionHeaderExpanded = (isExpanded ?? true)
        }
    }

    func setFooterValues(_ reuseId: String, nibName: String, height: CGFloat, model: Any?) {
        self.sectionFooterModel = model
        self.sectionFooterHeight = height
        self.sectionFooterReuseId = reuseId
        self.sectionFooterNibName = nibName
    }
    
    func getHeaderExpanded() -> Bool {
        return sectionHeaderExpanded ?? true
    }
    
    func setHeaderExpanded(value: Bool) {
        self.sectionHeaderExpanded = value
    }

    func appendCells(cells: [CellViewModel]) {
        self.cells.append(contentsOf: cells)
    }
    
    func insertCell(cell: CellViewModel, at index: IndexPath) {
        self.cells.insert(cell, at: index.row)
    }

    func deleteCells(indices: [Int]) {
        indices.forEach {self.cells.remove(at: $0)}
    }

    func updateCell(cellIndex: Int, newValue: CellViewModel) {
        self.cells[cellIndex] = newValue
    }
    
    func getHeaderExpandable() -> Bool {
        return sectionHeaderExpandable ?? false
    }
    
}

extension DefaultSection {
    func getHeaderReuseId() -> String? {
        return sectionHeaderReuseId
    }

    func getHeaderNibName() -> String? {
        return sectionHeaderNibName
    }

    func getHeaderHeight() -> CGFloat? {
        return sectionHeaderHeight ?? CGFloat.leastNonzeroMagnitude
    }

    func getHeaderModel() -> Any? {
        return sectionHeaderModel
    }

    func getFooterReuseId() -> String? {
        return sectionFooterReuseId
    }

    func getFooterNibName() -> String? {
        return sectionFooterNibName
    }

    func getFooterHeight() -> CGFloat? {
        return sectionFooterHeight ?? CGFloat.leastNonzeroMagnitude
    }

    func getFooterModel() -> Any? {
        return sectionFooterModel
    }
}
