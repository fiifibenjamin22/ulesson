//
//  Subject.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/28/21.
//

import UIKit

struct Subject: Codable {
    var name: String
    
    init(subject: String) {
        self.name = subject
    }
}

