//
//  Shots.swift
//  Pixel
//
//  Created by Hanif Sugiyanto on 10/31/17.
//  Copyright © 2017 extrainteger. All rights reserved.
//

import Foundation
import SwiftyJSONModel

struct Shots {
    
    let id:Int
    let title:String
    let description:String
    let width:Int
    let height:Int
    let images:String
    let likesCount:Int

}


extension Shots: JSONObjectInitializable {
    enum PropertyKey:String {
        case id, title, description, width, height, likes_count
        case images, hidpi
    }
    init(object: JSONObject<PropertyKey>) throws {
        id = try object.value(for: .id)
        title = try object.value(for: .title)
        description = try object.value(for: .description)
        width = try object.value(for: .width)
        height = try object.value(for: .height)
        images = try object.value(for: .images, .hidpi)
        likesCount = try object.value(for: .likes_count)
    }
}
