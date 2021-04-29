//
//  Food+CoreDataProperties.swift
//  Foodecide
//
//  Created by Farrel Anshary on 29/04/21.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var name: String?
    @NSManaged public var oilContent: Int64
    @NSManaged public var price: Int64
    @NSManaged public var size: Int64

}

extension Food : Identifiable {

}
