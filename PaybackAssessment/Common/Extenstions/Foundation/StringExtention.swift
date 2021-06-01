//
//  StringExtention.swift
//  Space-X
//
//  Created by mohammad on 5/18/21.
//

import Foundation
import UIKit

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
            let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
            return boundingBox.height
        }
    
    func localize(_ comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    
    var utf8Data: Data {
        guard let data = data(using: .utf8) else {
            fatalError("Could not convert string to data with encoding utf8")
        }
        return data
    }
    
    var float: Float? {
        return Float(self)
    }
    
    var int: Int? {
        return Int(self)
    }
    
    var firstUppercased: String {
        return prefix(1).uppercased()  + dropFirst()
    }
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    var charactersArray: [Character] {
        return Array(self)
    }
    
    func dateToHoure() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let date = dateFormatter.date(from: self)
        let newHour = dateFormatter.string(from: date ?? Date())
        return newHour
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date ?? Date()
    }
    
    func convertDateToLocalDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = dateFormatter.date(from: self)

        return localDate
    }
    
    func convertHtmlTextToAttributedString(fontName: String? = "SourceSansPro-Regular", fontSize: CGFloat? = 18.0) -> NSAttributedString? {
        let fontName: String = fontName ?? "SourceSansPro-Regular"
        let fontSize: CGFloat = fontSize ?? 18.0
        let aux = String(format: "<span style=\"font-family: '\(fontName)'; font-size:\(fontSize)\">%@</span>", self)
      
        guard let data = aux.data(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue)) else {
            return nil
        }
        guard let str = try? NSMutableAttributedString.init(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else {
            return nil
        }
        
        let textColor = UIColor(colorName: .appNavy)
        str.addAttributes([NSAttributedString.Key.foregroundColor: textColor], range: NSRange(location: 0, length: str.length))
        return str
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    mutating func trim() -> String {
        self = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return self
    }
    
    mutating func trimAllSpaces() -> String {
        self = self.replacingOccurrences(of: " ", with: "")
        return self
    }
    
    var isValidOrganizationID: Bool {
        let regEx = "^[a-zA-Z0-9_-]+$"
        let contactNumberTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return contactNumberTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        return self.count >= 8
    }
    
    var isInvalidPassword: Bool {
        return self.count < 8
    }
    
    var isValidFullName: Bool {
        let regEx = "^[a-zA-Z]+[a-zA-Z- ]*$"
        let contactNumberTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return contactNumberTest.evaluate(with: self)
    }
    
    var isValidName: Bool {
        let regEx = "^[a-zA-Z-_]+[a-zA-Z-_' ]*$"
        let contactNumberTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return contactNumberTest.evaluate(with: self)
    }
    
    var isValidNumber: Bool {
        let contactNumberRegEx = "^[+]?[0-9]*$"
        let contactNumberTest = NSPredicate(format: "SELF MATCHES %@", contactNumberRegEx)
        return contactNumberTest.evaluate(with: self)
    }
    
    var isValidContactNumber: Bool {
//        let contactNumberRegEx = "^[0][0-9]{9}|^[1-9][0-9]{8}$"
        let contactNumberRegEx = "^[1-9][0-9]*$"
        let contactNumberTest = NSPredicate(format: "SELF MATCHES %@", contactNumberRegEx)
        return contactNumberTest.evaluate(with: self)
    }
    
    func getNumber() -> String? {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    var isValidVerificationCode: Bool {
        let contactNumberRegEx = "^[0-9]{6}$"
        let contactNumberTest = NSPredicate(format: "SELF MATCHES %@", contactNumberRegEx)
        return contactNumberTest.evaluate(with: self)
    }
    
    func addSpacing(_ font: UIFont?, spacing: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: self.count))
        if let font = font {
            attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: self.count))
        }
        return attributedString
    }
    
    func estimateWidhtSize(padding: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude,
                          height: CGFloat.greatestFiniteMagnitude) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [.font: font],
            context: nil).width + padding
    }
    
    func estimateHeightSize(padding: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude,
                          height: CGFloat.greatestFiniteMagnitude) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [.font: font],
                                                   context: nil).height + padding
    }
    
    func size(font: UIFont, width: CGFloat) -> CGSize {
        let attrString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font: font])
        let bounds = attrString.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        let size = CGSize(width: bounds.width, height: bounds.height)
        return size
    }
    
    func convertTimeToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.date(from: self)
    }
}
