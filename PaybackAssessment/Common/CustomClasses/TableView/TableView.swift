//
//  TableView.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import UIKit

protocol PaginationProtocol: NSObjectProtocol {
    func loadNextPage()
}

protocol ScrollEventProtocols: NSObjectProtocol {
    func tableViewBeginsScrolling()
    func tableViewDidScroll(scrollView: UIScrollView)
}

protocol EditingProtocol: NSObjectProtocol {
    func rowDeleted(_ model: CellViewModel)
}

class DefaultTableView: UITableView {
    var sections = [SectionViewModel]()
    var customDataSource: TableDataSource! {
        didSet {
            self.customDataSource.onDataSourceChanged = { [weak self] in
                guard let self = self else {return}
                self.sections = self.customDataSource.sections
                self.onDataSourceChanged?()
            }
            self.customDataSource.didSelectExpandableSection = { [weak self] model in
                guard let self = self else {return}
                self.didSelectExpandableSection?(model)
            }
            self.customDataSource.didSelectTableView = { [weak self] (model, indexPath) in
                guard let self = self else {return}
                self.didSelectTableView?(model, indexPath)
            }
        }
    }
    lazy var emptyListView: EmptyListView
        = {
        
        EmptyListView.loadFromNib()
    }()
    var onDataSourceChanged: (() -> Void)?

    var didSelectTableView: ((Any, IndexPath) -> Void)?
    var didSelectExpandableSection: ((Any) -> Void)?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    func displayData(_ dataSource: TableDataSource) {
        self.customDataSource = dataSource
        self.sections = customDataSource.sections
        registerSectionAndCells()
        self.dataSource = customDataSource
        self.delegate = customDataSource
        self.prefetchDataSource = customDataSource
        self.reloadData()
    }

    func registerSectionAndCells() {
        self.sections.forEach { (section) in
            if let headerNibName = section.getHeaderNibName(), let headerReuseId = section.getHeaderReuseId() {
                self.register(UINib.init(nibName: headerNibName, bundle: nil), forHeaderFooterViewReuseIdentifier: headerReuseId)
            }
            if let footerNibName = section.getFooterNibName(), let footerReuseId = section.getFooterReuseId() {
                self.register(UINib.init(nibName: footerNibName, bundle: nil), forHeaderFooterViewReuseIdentifier: footerReuseId)
            }
            section.cells.forEach { (cell) in
                self.register(UINib.init(nibName: cell.nibName, bundle: nil), forCellReuseIdentifier: cell.reuseId)
            }
        }
    }

    func setTableHeaderView(_ view: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CGFloat.leastNonzeroMagnitude))) {
        self.tableHeaderView = view
    }

    func appendCells(cells: [CellViewModel], sectionIndex: Int) {
        self.customDataSource.sections[sectionIndex].appendCells(cells: cells)
        self.sections = self.customDataSource.sections
        cells.forEach { (cell) in
            self.register(UINib.init(nibName: cell.nibName, bundle: nil), forCellReuseIdentifier: cell.reuseId)
        }
        self.reloadData()
    }

    func setTableFooter(_ view: UIView) {
        self.tableFooterView = view
    }

    func removeTableFooter() {
        self.tableFooterView = nil
    }

    func showEmptyListView(_ text: String?, icon: UIImage? = nil, buttonText: String? = nil, backgroundColor: UIColor? = nil, buttonTapHandler: (() -> Void)? = nil) {
        self.backgroundView = self.emptyListView
        self.emptyListView.setEmptyText(text)
        self.emptyListView.setIcon(icon)
        self.emptyListView.backgroundColor = backgroundColor ?? .white
        self.emptyListView.configureButton(buttonText) {
            buttonTapHandler?()
        }
    }

    func hideEmptyListView() {
        self.backgroundView = nil
    }

    func deleteItems(_ indices: [IndexPath]) {
        let removedItems = self.customDataSource.deleteItemsFromDataSource(indices)
        self.sections = self.customDataSource.sections
        if !removedItems.toBeRemovedSection.isEmpty {
            self.deleteSections(removedItems.toBeRemovedSection, with: .automatic)
        } else {
            self.deleteRows(at: removedItems.toBeRemovedCells, with: .automatic)
        }
    }

    func updateDataSource(sections: [SectionViewModel]) {
        self.customDataSource.updateDataSource(sections: sections)
    }

    func updateDataSourceAndMoveRows(sections: [SectionViewModel], atIndexPath: IndexPath, toIndexPath: IndexPath) {
        self.customDataSource.updateDataSource(sections: sections)
        if (self.cellForRow(at: atIndexPath) != nil) && (self.cellForRow(at: toIndexPath) != nil) {
            self.moveRow(at: atIndexPath, to: toIndexPath)
            self.reloadRows(at: [atIndexPath], with: .none)
            self.reloadRows(at: [toIndexPath], with: .none)
        } else {
            self.reloadData()
        }
    }

    func updateDataSourceAndReloadCells(sections: [SectionViewModel], updateIndexPath: [IndexPath?]) {
        self.customDataSource.updateDataSource(sections: sections)
        let updatedIndexpathes = updateIndexPath.compactMap { $0 }
        let cellsNeedReload = updatedIndexpathes.map { self.cellForRow(at: $0) }
        if cellsNeedReload.contains(where: {$0 != nil}) {
            self.reloadRows(at: updatedIndexpathes, with: .none)
        } else {
            self.reloadData()
        }
    }

    func moveItem(atIndexPath: IndexPath, toIndexPath: IndexPath) {
        self.customDataSource.moveItemInDataSource(atIndexPath: atIndexPath, toIndexPath: toIndexPath)
    }

    func isTableViewEmpty() -> Bool {
        if self.sections.isEmpty || (self.sections.first?.cells.isEmpty ?? true) {
            return true
        } else {
            return false
        }
    }
}

