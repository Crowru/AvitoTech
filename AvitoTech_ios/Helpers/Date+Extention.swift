//
//  Date.swift
//  AvitoTech
//
//  Created by Руслан  on 28.08.2023.
//

import UIKit

private let inputDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-d"
    return formatter
}()

private let outputDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM, yyyy"
    formatter.locale = Locale(identifier: "ru_RU")
    return formatter
}()

extension UICollectionViewCell {
    func convertDate(from date: String) -> String {
        var formattedDate = ""
        if let date = inputDateFormatter.date(from: date) {
            formattedDate = outputDateFormatter.string(from: date)
        }
        return formattedDate
    }
}
