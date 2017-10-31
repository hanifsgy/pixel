//
//  JSONExtension.swift
//  SwiftyJSONModel
//
//  Created by Oleksii on 17/09/16.
//  Copyright © 2016 Oleksii Dykan. All rights reserved.
//

import Foundation
import SwiftyJSON

public extension JSON {
    public func value() throws -> Bool {
        guard let boolValue = bool else { throw JSONModelError.invalidElement }
        return boolValue
    }
    
    public func value() throws -> Int {
        guard let intValue = int else { throw JSONModelError.invalidElement }
        return intValue
    }
    
    public func value() throws -> Double {
        guard let doubleValue = double else { throw JSONModelError.invalidElement }
        return doubleValue
    }
    
    public func value() throws -> String {
        guard let stringValue = string else { throw JSONModelError.invalidElement }
        return stringValue
    }
    
    public func arrayValue() throws -> [JSON] {
        guard let arrayValue = array else { throw JSONModelError.invalidElement }
        return arrayValue
    }
    
    public func dictionaryValue() throws -> [String: JSON] {
        guard let dictValue = dictionary else { throw JSONModelError.invalidElement }
        return dictValue
    }
}
