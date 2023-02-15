//
//  Utils.swift
//  FoodTracker
//
//  Created by Jiajia Li on 2/8/23.
//

import Foundation

class Utils {
    class func getFormatedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
}
