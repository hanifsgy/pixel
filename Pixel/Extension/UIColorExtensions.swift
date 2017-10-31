//
//  UIColorExtensions.swift
//  Pixel
//
//  Created by Hanif Sugiyanto on 10/31/17.
//  Copyright © 2017 extrainteger. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
// implement Hex code for color
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    struct FlatColor {
        struct Pink {
            static let pink = UIColor(netHex: 0xff68b3)
        }
        struct Orange {
            static let orange = UIColor(netHex: 0xf87a0b)
        }
    }
}

