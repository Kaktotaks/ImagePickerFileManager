//
//  DateExtensions.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 15.08.2022.
//

import Foundation

extension Date {
    func getCurrentUADate() -> String {
        let date = Date.now
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy HH:mm:ss"
        df.timeZone = .current
        let dateString = df.string(from: date)
        return dateString
    }
}
