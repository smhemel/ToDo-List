//
//  Category.swift
//  ToDo List
//
//  Created by S M HEMEL on 6/12/18.
//  Copyright © 2018 S M HEMEL. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
