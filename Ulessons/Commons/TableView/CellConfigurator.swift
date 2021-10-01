//
//  CellConfigurator.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import UIKit

protocol CellConfigurator {
    static var reuseId: String { get }
    func configure(cell: UIView)
}

class TableCellConfigurator<CellType: ConfigurableCell, Model>: CellConfigurator where CellType.Model == Model, CellType: UITableViewCell {
    static var reuseId: String { return String(describing: CellType.self) }
    
    var item: Model
    
    init(item: Model) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        guard let cell = cell as? CellType else { fatalError("Cell is not Configurable Cell") }
        cell.configure(with: item)
    }
}
