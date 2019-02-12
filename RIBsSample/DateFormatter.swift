//
//  DateFormatter.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/02/07.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import Foundation

protocol DateFormatter {
    var formatter: Foundation.DateFormatter { get }

    func date(_ string: String) -> Date?
    func string(_ date: Date) -> String
}

extension DateFormatter {
    func date(_ string: String) -> Date? {
        return formatter.date(from: string)
    }

    func string(_ date: Date) -> String {
        return formatter.string(from: date)
    }
}

struct StandardDateFormatter: DateFormatter {
    let formatter: Foundation.DateFormatter

    init(dateFormat: DateFormat, locale: Locale = .enUSPOSIX, calendar: Calendar.Identifier = .gregorian) {
        self.init(dateFormat: dateFormat.rawValue, locale: locale, calendar: calendar)
    }

    init(dateFormat: String, locale: Locale, calendar: Calendar.Identifier) {
        self.formatter = {
            let formatter = Foundation.DateFormatter()
            formatter.dateFormat = dateFormat
            formatter.locale = locale.value
            formatter.calendar = Calendar(identifier: calendar)
            return formatter
        }()
    }
}

enum Locale {
    case enUSPOSIX

    var value: Foundation.Locale {
        switch self {
        case .enUSPOSIX:
            return Foundation.Locale(identifier: "en_US_POSIX")
        }
    }
}

enum DateFormat: String {
    case date = "yyyy/MM/dd"
    case dateTime = "yyyy/MM/dd HH:mm"
}

