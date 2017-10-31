//
//  JSONObjectType.swift
//  SwiftyJSONModel
//
//  Created by Oleksii on 19/09/16.
//  Copyright © 2016 Oleksii Dykan. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct JSONObject<PropertyType: RawRepresentable & Hashable>: JSONInitializable {
    fileprivate let json: JSON
    
    public init(json: JSON) throws {
        guard json.type == .dictionary else {
            throw JSONModelError.jsonIsNotAnObject
        }
        self.json = json
    }
}

extension JSONObject: JSONRepresentable {
    public var jsonValue: JSON {
        return json
    }
}

public extension JSONObject where PropertyType.RawValue == String {
    public init(_ jsonDict: [PropertyType: JSONRepresentable?]) {
        var dict = [String: JSON]()
        
        for (key, value) in jsonDict {
            let jsonValue = value?.jsonValue ?? .null
            dict[key.rawValue] = jsonValue
        }
        
        json = JSON(dict)
    }
    
    public subscript(key: PropertyType) -> JSON {
        return json[key.rawValue]
    }
    
    // MARK: - Throwable methods
    public func object(for key: PropertyType) throws -> JSONObject<PropertyType> {
        do {
            return try JSONObject<PropertyType>(json: self[key])
        } catch let error as JSONModelError {
            throw JSONModelError.invalidValueFor(key: key.rawValue, error)
        }
    }
    
    public func value<T: JSONInitializable>(for keyPath: PropertyType...) throws -> T {
        return try value(for: keyPath)
    }
    
    public func value<T: JSONInitializable>(for keyPath: [PropertyType]) throws -> T {
        assert(keyPath.isEmpty == false, "KeyPath cannot be empty")
        
        let key = keyPath[0]
        do {
            if keyPath.count == 1 {
                return try T(json: self[key])
            } else {
                let subPath: [PropertyType] = .init(keyPath[1..<keyPath.count])
                return try JSONObject<PropertyType>(json: self[key]).value(for: subPath)
            }
        } catch let error as JSONModelError {
            throw JSONModelError.invalidValueFor(key: key.rawValue, error)
        }
    }
    
    public func value<T: JSONInitializable>(for keyPath: PropertyType...) throws -> [T] {
        return try value(for: keyPath)
    }
    
    public func value<T: JSONInitializable>(for keyPath: [PropertyType]) throws -> [T] {
        assert(keyPath.isEmpty == false, "KeyPath cannot be empty")
        
        let key = keyPath[0]
        do {
            if keyPath.count == 1 {
                return try self[key].arrayValue().enumerated().lazy.map({ index, json in
                    do {
                        return try T(json: json)
                    } catch let error as JSONModelError {
                        throw JSONModelError.invalidValueFor(key: String(index), error)
                    }
                })
            } else {
                let subPath: [PropertyType] = .init(keyPath[1..<keyPath.count])
                return try JSONObject<PropertyType>(json: self[key]).value(for: subPath)
            }
        } catch let error as JSONModelError {
            throw JSONModelError.invalidValueFor(key: key.rawValue, error)
        }
    }
    
    // MARK: - Optional methods
    public func value<T: JSONInitializable>(for keyPath: PropertyType...) -> T? {
        return try? value(for: keyPath)
    }
    
    public func value<T: JSONInitializable>(for keyPath: PropertyType...) -> [T]? {
        return try? value(for: keyPath)
    }
}
