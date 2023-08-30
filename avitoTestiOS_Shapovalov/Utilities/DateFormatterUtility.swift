//
//  DateFormatterUtility.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 30/08/23.
//

import Foundation

// DateFormatterUtility.swift
class DateFormatterUtility {
    static func formatDate(from originalString: String, fromFormat: String, toFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        guard let date = dateFormatter.date(from: originalString) else {
            return nil
        }
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }
}
