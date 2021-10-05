//
//  Filter.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import UIKit

enum Filter: String {
    case ALL_SUBJECT
    case MATHEMATICS
    case ENGLISH
    case CHEMISTRY
    case BIOLOGY
    case PHYSICS
    
    var displayedText: String {
        if self.rawValue.contains("_") {
            return rawValue.replacingOccurrences(of: "_", with: " ").capitalized
        }
        return self.rawValue.capitalized
    }
}

extension Filter: DropDownOption {
    
    var id: Int {
        return self.hashValue
    }
    
    var icon: UIImage? {
        return nil
    }
    
    var title: String {
        return displayedText
    }
    
}
