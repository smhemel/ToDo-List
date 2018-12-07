//
//  Item.swift
//  ToDo List
//
//  Created by S M HEMEL on 6/12/18.
//  Copyright © 2018 S M HEMEL. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
