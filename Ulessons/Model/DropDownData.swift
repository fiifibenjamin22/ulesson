//
//  DropDownData.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 10/5/21.
//

import UIKit

struct DropDownData {

    let icon: UIImage?
    let title: String
    let popupTitle: String
    let additionalInformation: String?
    let emptyOptionsButtonText: String?
    let options: [DropDownOption]
    let popupAddBottomButtonTitle: String?
    let canOpenOptionsPopup: Bool?
    
    // MARK: - Initialization
    init(icon: UIImage?,
         title: String,
         popupTitle: String,
         additionalInformation: String? = nil,
         emptyOptionsButtonText: String? = nil,
         options: [DropDownOption],
         popupAddBottomButtonTitle: String? = nil,
         canOpenOptionsPopup: Bool? = nil) {
        self.icon = icon
        self.title = title
        self.popupTitle = popupTitle
        self.additionalInformation = additionalInformation
        self.emptyOptionsButtonText = emptyOptionsButtonText
        self.options = options
        self.popupAddBottomButtonTitle = popupAddBottomButtonTitle
        self.canOpenOptionsPopup = canOpenOptionsPopup
    }
}

protocol DropDownOption {

    var id: Int { get }
    var icon: UIImage? { get }
    var title: String { get }

}
