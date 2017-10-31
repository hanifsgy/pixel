//
//  JSONTypes.swift
//  SwiftyJSONModel
//
//  Created by Oleksii on 18/09/16.
//  Copyright © 2016 Oleksii Dykan. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol JSONInitializable {
    init(json: JSON) throws
}

public protocol JSONRepresentable {
    var jsonValue: JSON { get }
}

extension String: JSONInitializable, JSONRepresentable {
    public init(json: JSON) throws { self = try json.value() }
    public var jsonValue: JSON { return JSON(self) }
}

extension Bool: JSONInitializable, JSONRepresentable {
    public init(json: JSON) throws { self = try json.value() }
    public var jsonValue: JSON { return JSON(self) }
}

extension Int: JSONInitializable, JSONRepresentable {
    public init(json: JSON) throws { self = try json.value() }
    public var jsonValue: JSON { return JSON(self) }
}

extension Double: JSONInitializable, JSONRepresentable {
    public init(json: JSON) throws { self = try json.value() }
    public var jsonValue: JSON { return JSON(self) }
}
