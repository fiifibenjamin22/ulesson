//
//  Strings.swift
//  Ulessons
//
//  Created by Benjamin Acquah on 9/29/21.
//

import UIKit

enum Strings: String {
    case title = "profile.title"
    case cellId = "cellId"
    case liveCellId = "liveCellId"
    case emptyLiveCellId = "emptyLiveCellId"
    case headerCellId = "headerCellId"
    case footerCellId = "footerCellId"
    case selectFilter = "filter.courses.select.course"
}

extension String {
    
    var isBlank: Bool {
        return trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func valid(withRegex regex: String?) -> Bool {
        guard let regex = regex else { return true }
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func attributtedText(withColor color: UIColor, font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let attributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
        attributedString.addAttributes(attributes, range: (self as NSString).range(of: self))
        return attributedString
    }
    
    func attributedFromHtml(withColor color: UIColor, font: UIFont) -> NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let mutable = try NSMutableAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil)
            mutable.addAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font], range: NSRange(location: 0, length: mutable.length))
            return mutable
        } catch {
            print("Error parsing from HTML: ", error)
            return nil
        }
    }
    
    func safelyLimitedTo(length: Int) -> String {
        if self.count <= length {
            return self
        }
        return String( Array(self).prefix(upTo: length) )
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
//    func checkIfVersionAppIsPreview(with text: String? = nil) -> String? {
//        return (Config.userProfile?.isPreview ?? false) ? text : self
//    }

    var url: URL? {
        return URL(string: addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
    }
}

extension Optional where Wrapped == String {
    
    var emptyIfNil: String {
        return self ?? ""
    }
    
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
    
    var isBlank: Bool {
        return self?.isBlank ?? true
    }
}
