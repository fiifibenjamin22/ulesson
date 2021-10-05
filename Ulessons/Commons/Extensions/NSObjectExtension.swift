//
//  NSObjectExtension.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import Foundation

protocol HasApply { }

extension HasApply {

    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }

}

extension NSObject: HasApply { }

extension NSObjectProtocol {
    
    static var name: String {
        return String(describing: self)
    }
    
}

