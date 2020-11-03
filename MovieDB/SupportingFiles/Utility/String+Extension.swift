//
//  String+Extension.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation

extension String {
    var wordList: [String] {
        return components(separatedBy: CharacterSet.alphanumerics.inverted).filter { !$0.isEmpty }
    }

    func getYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        guard let formatedDate = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "MM/DD/YYYY"
        return dateFormatter.string(from: formatedDate)
    }
}
