//
//  ConfigurableCell.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import UIKit

protocol ConfigurableCell {
    associatedtype Model
    func configure(with model: Model)
}
