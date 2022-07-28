//
//  Date.swift
//  Tracker
//
//  Created by Daichi Morihara on 2022/07/28.
//

import Foundation

extension Date {
    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }
    
    func asDayString() -> String {
        return self.dayFormatter.string(from: self)
    }
    
}

