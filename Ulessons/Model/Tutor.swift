//
//  Tutor.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

struct Tutor: Codable {
    var firstname: String
    var lastname: String?
    
    init(firstName: String, lastName: String) {
        self.firstname = firstName
        self.lastname = lastName
    }
}
