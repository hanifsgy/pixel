//
//  UIFontExtensions.swift
//  Pixel
//
//  Created by Hanif Sugiyanto on 10/31/17.
//  Copyright © 2017 extrainteger. All rights reserved.
//

import Foundation
import UIKit


extension UIFont {
    
    func robotoBold(size: CGFloat?) -> UIFont {
        var fontSize: CGFloat = 12
        if let size = size {
            fontSize = size
        }
        return UIFont(name: "Roboto-Bold", size: fontSize)!
    }
    
    func robotoMedium(size: CGFloat?) -> UIFont {
        var fontSize: CGFloat = 12
        if let size = size {
            fontSize = size
        }
        return UIFont(name: "Roboto-Medium", size: fontSize)!
    }
    
    func robotoRegular(size: CGFloat?) -> UIFont {
        var fontSize: CGFloat = 12
        if let size = size {
            fontSize = size
        }
        return UIFont(name: "Roboto-Regular", size: fontSize)!
    }
    
    func robotoLight(size: CGFloat?) -> UIFont {
        var fontSize: CGFloat = 12
        if let size = size {
            fontSize = size
        }
        return UIFont(name: "Roboto-Light", size: fontSize)!
    }
}


