//
//  TableViewManager.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import UIKit

protocol TableManagerDelegate: class {
    func didSwipeForRefresh()
    func loadMoreData()
    func tableViewDidScroll(_ scrollView: UIScrollView)
}

enum FooterStyle {
    case light
    case dark
    
    var indicatorStyle: UIActivityIndicatorView.Style {
        switch  self {
        case .light: return .gray
        case .dark: return .white
        }
    }
}

class TableViewManager: NSObject {

    // MARK: - Private Properties
    private let tableView: UITableView
    private var items: [TableSection] = []
    
    private var cellHeightCache: [IndexPath: CGFloat] = [:]
    private var sectionHeaderHeightCache: [Int: CGFloat] = [:]
    private var sectionFooterHeightCache: [Int: CGFloat] = [:]

    private(set) var refreshControl: UIRefreshControl?

    private weak var delegate: TableManagerDelegate?
    
    var footerStyle: FooterStyle = .light {
        didSet {
            updateFooterStyle()
        }
    }

    // MARK: - Lifecycle
    init(tableView: UITableView, delegate: TableManagerDelegate?) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        setUp()
    }

    private func setUp() {
        tableView.apply {
            $0.dataSource = self
            $0.delegate = self

            $0.rowHeight = UITableView.automaticDimension
            $0.sectionHeaderHeight = UITableView.automaticDimension
            $0.sectionFooterHeight = UITableView.automaticDimension
        }

        showTableViewFooter()
    }
}

// MARK: - Public methods
extension TableViewManager {

    func setupWith(sections: [TableSection]) {
        stopRefreshing()
        
        sections.cellsToRegister().forEach(tableView.registerCell)
        sections.headersToRegister().forEach(tableView.registerHeaderFooter)
        sections.footersToRegister().forEach(tableView.registerHeaderFooter)

        items.removeAll()
        items.append(contentsOf: sections)

        tableView.apply {
            $0.sectionHeaderHeight = sections.headersToRegister().isEmpty ? CGFloat.leastPositiveForTableView : UITableView.automaticDimension
            $0.reloadData()
        }
    }
    
    func uploadWith(sections: [TableSection]) {
        stopRefreshing()
        let currentContentOffset = tableView.contentOffset
        sections.cellsToRegister().forEach(tableView.registerCell)
        sections.headersToRegister().forEach(tableView.registerHeaderFooter)
        sections.footersToRegister().forEach(tableView.registerHeaderFooter)
        
        items.removeAll()
        items.append(contentsOf: sections)
        
        tableView.apply {
            $0.sectionHeaderHeight = sections.headersToRegister().isEmpty ? CGFloat.leastPositiveForTableView : UITableView.automaticDimension
            $0.reloadData()
            if #available(iOS 13, *) {} else {
                $0.layoutIfNeeded()
                self.tableView.contentOffset = currentContentOffset
                if currentContentOffset.y > tableView.contentSize.height - tableView.frame.height {
                    UIView.animate(withDuration: 0.3) { [unowned self] in
                        self.tableView.contentOffset.y = max(
                            self.tableView.frame.origin.y - (UIApplication.shared.statusBar?.frame.height ?? 0),
                            self.tableView.contentSize.height - self.tableView.frame.height)
                    }
                }
            }
        }
    }

    func removeAllItems() {
        self.items = []
        self.tableView.reloadData()
    }
    
    func showLoadingFooter() {
        showTableViewFooter()
    }

    func hideLoadingFooter() {
        tableView.tableFooterView = nil
        stopRefreshing()
    }

    func scrollToTop() {
        if tableView.contentInset.top > 0 {
            tableView.setContentOffset(CGPoint(x: 0, y: -tableView.contentInset.top), animated: true)
        } else {
            tableView.setContentOffset(.zero, animated: true)
        }
    }

    func invalidateCache() {
        sectionFooterHeightCache.removeAll()
        sectionHeaderHeightCache.removeAll()
        cellHeightCache.removeAll()
    }

    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.appGrey
        refreshControl?.addTarget(self, action: #selector(didPullDownRefreshControl), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
    }
    
    func setSections(_ sections: [TableSection]) {
        items = sections
    }
}

// MARK: - Private methods
extension TableViewManager {
    
    private func updateFooterStyle() {
        guard let footerView = tableView.tableFooterView as? TableIndicatorView else { return }
        footerView.activityIndicator.style = footerStyle.indicatorStyle
    }

    private func showTableViewFooter() {
        guard tableView.tableFooterView == nil && refreshControl?.isRefreshing != true else { return }

        let footer = TableIndicatorView()
        tableView.tableFooterView = footer
        updateFooterStyle()
    }

    @objc private func didPullDownRefreshControl() {
        guard !tableView.isDragging else { return }
        delegate?.didSwipeForRefresh()
    }

    private func stopRefreshing() {
        if refreshControl?.isRefreshing == true {
            refreshControl?.endRefreshing()
        }
    }

}

// MARK: - Table View Data Source
extension TableViewManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableSection = items[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: tableSection.cellReuseIdentifier, for: indexPath)

        tableSection.configure(cell: cell, at: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableSection = items[section]

        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: tableSection.headerReuseIdentifier) {
            tableSection.configure(header: header, in: section)
            
            return header
        }

        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tableSection = items[section]

        if let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: tableSection.footerReuseIdentifier) {
            tableSection.configure(footer: footer, in: section)
            return footer
        }

        return UIView()
    }

}

// MARK: - Table View Delegate
extension TableViewManager: UITableViewDelegate {
    
    // MARK: - Cache list elements heights
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeightCache[indexPath] = cell.frame.size.height
        if shouldCallNextPage(basedOn: indexPath) {
            delegate?.loadMoreData()
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        sectionHeaderHeightCache[section] = view.frame.size.height
    }

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        sectionFooterHeightCache[section] = view.frame.size.height
    }

    // MARK: = Retrieve saved heights from cache
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightCache[indexPath] ?? CGFloat.leastPositiveForTableView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.section].tableView(tableView, heightForRowAt: indexPath) ?? cellHeightCache[indexPath] ?? UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeightCache[section] ?? CGFloat.leastPositiveForTableView
    }

    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return sectionFooterHeightCache[section] ?? CGFloat.leastPositiveForTableView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.tableViewDidScroll(scrollView)
    }

    // MARK: - Helper methods
    private func shouldCallNextPage(basedOn indexPath: IndexPath) -> Bool {
        var indexInWholeTable: Int = 0
        for section in 0 ..< indexPath.section {
            indexInWholeTable += tableView.numberOfRows(inSection: section)
        }
        indexInWholeTable += indexPath.item + 1

        let currentIndexRatio = Double(indexInWholeTable) / Double(items.reduce(0, { $0 + $1.numberOfItems }))
        return tableView.indexPathsForVisibleRows?.contains(indexPath) == true &&
            (currentIndexRatio >= Constants.defaultPagingCap) &&
            (tableView.contentSize.height > tableView.frame.height)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard refreshControl?.isRefreshing == true else { return }
        delegate?.didSwipeForRefresh()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = items[indexPath.section]
        section.didSelectItem(tableView, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cell = tableView.cellForRow(at: indexPath) else { return indexPath }
        let section = items[indexPath.section]
        return section.willSelectItem(at: indexPath, cell: cell)
    }
}
