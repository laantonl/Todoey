//
//  Item.swift
//  Todoey
//
//  Created by Anthony Anton on 18/11/18.
//  Copyright © 2018 Anthony Anton. All rights reserved.
//

import Foundation
class Item : Codable { //Encodable, Decodable
    var title : String = ""
    var done : Bool = false
}
