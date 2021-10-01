//
//  TableSection.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import UIKit

protocol TableSection {

    var cellReuseIdentifier: String { get }
    var headerReuseIdentifier: String { get }
    var footerReuseIdentifier: String { get }

    var cellType: UITableViewCell.Type { get }
    var headerType: UITableViewHeaderFooterView.Type? { get }
    var footerType: UITableViewHeaderFooterView.Type? { get }

    var numberOfItems: Int { get }
    func getItems<T>() -> [T]?
    func setItems<T>(_ items: [T])

    func configure(cell: UITableViewCell, at indexPath: IndexPath)
    func configure(header: UITableViewHeaderFooterView, in section: Int)
    func configure(footer: UITableViewHeaderFooterView, in section: Int)
    
    func willSelectItem(at indexPath: IndexPath, cell: UITableViewCell) -> IndexPath?
    func didSelectItem(_ tableView: UITableView, at indexPath: IndexPath)

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat?
}

class BasicTableSection<Model, Cell: UITableViewCell>: TableSection where Cell: ConfigurableCell, Model == Cell.Model {
    
    // MARK: Items
    var items: [Model]

    let itemSelector: ((Model) -> Void)

    init(items: [Model], itemSelector: @escaping ((Model) -> Void) = { _ in }) {
        self.items = items
        self.itemSelector = itemSelector
    }

    // MARK: Identifiers and types
    var cellReuseIdentifier: String { return Cell.name }

    var headerReuseIdentifier: String { return headerType?.name ?? "" }

    var footerReuseIdentifier: String { return footerType?.name ?? "" }

    var cellType: UITableViewCell.Type { return Cell.self }

    var headerType: UITableViewHeaderFooterView.Type? { return nil }

    var footerType: UITableViewHeaderFooterView.Type? { return nil }

    // MARK: Items
    var numberOfItems: Int { return items.count }

    func getItems<T>() -> [T]? {
        guard let items = items as? [T] else { return nil }

        return items
    }
    
    func setItems<T>(_ items: [T]) {
        guard let items = items as? [Model] else { return }
        self.items = items
    }

    // MARK: Configuration methods
    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? Cell, Model.self == Cell.Model.self else {
            fatalError("Model must be the same as is defined in Cell")
        }
        cell.configure(with: items[indexPath.item])
    }

    func configure(footer: UITableViewHeaderFooterView, in section: Int) { }

    func configure(header: UITableViewHeaderFooterView, in section: Int) { }
    
    func willSelectItem(at indexPath: IndexPath, cell: UITableViewCell) -> IndexPath? {
        return indexPath
    }

    func didSelectItem(_ tableView: UITableView, at indexPath: IndexPath) {
        itemSelector(items[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat? {
        return nil
    }
}

extension Array where Element == TableSection {

    func cellsToRegister() -> [UITableViewCell.Type] {
        var cells: [UITableViewCell.Type] = []
        forEach { element in
            if !cells.contains(where: { $0 == element.cellType }) {
                cells.append(element.cellType)
            }
        }

        return cells
    }

    func headersToRegister() -> [UITableViewHeaderFooterView.Type] {
        var headers: [UITableViewHeaderFooterView.Type] = []
        forEach { element in
            if let headerType = element.headerType, !headers.contains(where: { $0 == headerType }) {
                headers.append(headerType)
            }
        }

        return headers
    }

    func footersToRegister() -> [UITableViewHeaderFooterView.Type] {
        var footers: [UITableViewHeaderFooterView.Type] = []
        forEach { element in
            if let footerType = element.footerType, !footers.contains(where: { $0 == footerType }) {
                footers.append(footerType)
            }
        }

        return footers
    }
}
