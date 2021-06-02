//
//  DateExtention.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/30/1400 AP.
//

import Foundation

extension Date {
    func toString(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        
        return str
    }
    
    func isDateInToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
}
