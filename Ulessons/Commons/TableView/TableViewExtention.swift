//
//  TableViewExtention.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import UIKit

extension UITableView {

    func registerHeaderFooter(_ headerFooterClass: UITableViewHeaderFooterView.Type) {
        self.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: headerFooterClass.name)
    }

    func registerCell(_ cellClass: UITableViewCell.Type) {
        self.register(cellClass, forCellReuseIdentifier: cellClass.name)
    }

    func dequeueReusableCell<T: UITableViewCell>(
        with identifier: String? = nil,
        for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier ?? T.name, for: indexPath) as? T else {
            fatalError("Cannot dequeue: \(T.self) with identifier: \(T.name)")
        }

        return cell
    }

    func dequeueReusableHeaderFooter<T: UIView>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.name) as? T else {
            fatalError("Cannot dequeue header footer: \(T.self) with identifier: \(T.name)")
        }

        return headerFooter
    }
    
    func layoutTableHeaderView() {
        guard let headerView = self.tableHeaderView else { return }
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerWidth = headerView.bounds.size.width
        let temporaryWidthConstraint = headerView.widthAnchor.equalTo(constant: headerWidth)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        headerView.removeConstraint(temporaryWidthConstraint)
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }

}
