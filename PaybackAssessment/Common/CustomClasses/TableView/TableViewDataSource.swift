//
//  TableViewDataSource.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import UIKit

protocol TableDataSource: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    var sections: [SectionViewModel] {get}
    func deleteItemsFromDataSource(_ indices: [IndexPath]) -> (toBeRemovedSection: IndexSet, toBeRemovedCells: [IndexPath])
    var onDataSourceChanged: (() -> Void)? {get set}
    var didSelectTableView: ((Any, IndexPath) -> Void)? {get set}
    var didSelectExpandableSection: ((SectionViewModel) -> Void)? {get set}
    func updateDataSource(sections: [SectionViewModel])
    func moveItemInDataSource(atIndexPath: IndexPath, toIndexPath: IndexPath)
}

// MARK: Default Implementations

class DefaultTableViewDataSource: NSObject, TableDataSource {
    var sections: [SectionViewModel] {
        didSet {
            onDataSourceChanged?()
        }
    }
    weak var paginationProtocol: PaginationProtocol?
    weak var scrollEventProtocol: ScrollEventProtocols?
    var onDataSourceChanged: (() -> Void)?
    var didSelectTableView: ((Any, IndexPath) -> Void)?
    var didSelectExpandableSection: ((SectionViewModel) -> Void)?
    
    init(sections: [SectionViewModel], paginationDelegate: PaginationProtocol? = nil) {
        self.sections = sections
        self.paginationProtocol = paginationDelegate
    }
    
    func deleteItemsFromDataSource(_ indices: [IndexPath]) -> (toBeRemovedSection: IndexSet, toBeRemovedCells: [IndexPath]) {
        let toBeRemovedSections = NSMutableIndexSet()
        indices.forEach { (index) in
            self.sections[index.section].deleteCells(indices: [index.row])
            if self.sections[index.section].cells.isEmpty {
                self.sections.remove(at: index.section)
                toBeRemovedSections.add(index.section)
            }
        }
        return (toBeRemovedSections as IndexSet, indices)
    }
    
    func moveItemInDataSource(atIndexPath: IndexPath, toIndexPath: IndexPath) {
        if self.sections.indices.contains(atIndexPath.section) {
            let section = self.sections[atIndexPath.section]
            self.sections.remove(at: atIndexPath.section)
            self.sections.insert(section, at: toIndexPath.section)
        }
    }
    
    func updateDataSource(sections: [SectionViewModel]) {
        self.sections = sections
    }
}

extension DefaultTableViewDataSource: UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections[section].getHeaderExpanded() {
            let count = sections[section].cells.count
            return count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = sections[indexPath.section].cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.reuseId, for: indexPath)
        (cell as? Binder)?.bind(cellViewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = sections[indexPath.section].cells[indexPath.row]
        self.didSelectTableView?(cellViewModel, indexPath)
    }
}

extension DefaultTableViewDataSource: UIGestureRecognizerDelegate {
    @objc func handleTap(sender: UIGestureRecognizer) {
        guard let tableView = sender.view?.superview as? UITableView else { return }
        
        guard let index = sender.view?.tag else { return }
        let isExpanded = sections[index].getHeaderExpanded()
        sections[index].setHeaderExpanded(value: !isExpanded)
        self.didSelectExpandableSection?(sections[index])
        
        if isExpanded {
            UIView.animate(withDuration: 0.3) {
                tableView.scrollToRow(at: IndexPath(item: NSNotFound, section: index), at: .bottom, animated: false)
            }
        } else {
            
            UIView.animate(withDuration: 0.3) {
                tableView.scrollToRow(at: IndexPath(item: NSNotFound, section: index), at: .top, animated: true)
            }
        }
    }
}
extension DefaultTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].getHeaderHeight() ?? 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        func setExpandableOptions(headerView: UIView) {
            if sections[section].getHeaderExpandable() {
                headerView.tag = section
                let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
                tapRecognizer.delegate = self
                tapRecognizer.numberOfTapsRequired = 1
                tapRecognizer.numberOfTouchesRequired = 1
                headerView.addGestureRecognizer(tapRecognizer)
            }
        }
        
        guard let reuseId = sections[section].getHeaderReuseId() else {
            if let nibName = sections[section].getHeaderNibName() {
                if let view = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as? UIView {
                    (view as? Binder)?.bind(sections[section])
                    if view.tag != section {
                        setExpandableOptions(headerView: view)
                        
                    }
                    return view
                }
                return nil
            }
            return nil
        }
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseId) {
            (view as? Binder)?.bind(sections[section])
            setExpandableOptions(headerView: view)
            return view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].getFooterHeight() ?? 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let reuseId = sections[section].getFooterReuseId() else {
            return nil
        }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseId)
        (view as? Binder)?.bind(sections[section])
        return view
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let tableView: UITableView = scrollView as? UITableView {
            if let lastCell = tableView.visibleCells.last {
                guard let indexPath = tableView.indexPath(for: lastCell) else { return }
                let cellCount = sections.reduce(0) {$0 + $1.cells.count}
                if indexPath.row == (cellCount - 1) {
                    self.paginationProtocol?.loadNextPage()
                }
            }
        } else {
            let height = scrollView.frame.size.height
            let contentYoffset = scrollView.contentOffset.y
            let distanceFromBottom = scrollView.contentSize.height - contentYoffset
            if distanceFromBottom < height {
                self.paginationProtocol?.loadNextPage()
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.scrollEventProtocol?.tableViewBeginsScrolling()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollEventProtocol?.tableViewDidScroll(scrollView: scrollView)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(colorName: .appWhite)
            headerView.backgroundView = backgroundView
        }
    }
}
