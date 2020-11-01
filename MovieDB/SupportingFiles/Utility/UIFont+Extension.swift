//
//  UIFonts+Extension.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 01/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func getGothicBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "GothicA1-Bold", size: size)!
    }

    static func getGothicMediumFont(size: CGFloat) -> UIFont {
        return UIFont(name: "GothicA1-Medium", size: size)!
    }

    static func getGothicSemiBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "GothicA1-SemiBold", size: size)!
    }

    static func getGothicRegularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "GothicA1-Regular", size: size)!
    }
}
