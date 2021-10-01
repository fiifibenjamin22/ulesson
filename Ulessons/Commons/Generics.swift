//
//  Generics.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}

public extension Sequence where Element: Equatable {
    var uniqueElements: [Element] {
        return self.reduce(into: []) { uniqueElements, element in
            if !uniqueElements.contains(element) {
                uniqueElements.append(element)
            }
        }
    }
}
