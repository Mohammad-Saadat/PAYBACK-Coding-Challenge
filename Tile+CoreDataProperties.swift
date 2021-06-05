//
//  Tile+CoreDataProperties.swift
//  
//
//  Created by mohammadSaadat on 3/15/1400 AP.
//
//

import Foundation
import CoreData


extension Tile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tile> {
        return NSFetchRequest<Tile>(entityName: "Tile")
    }

    @NSManaged public var data: String?
    @NSManaged public var headline: String?
    @NSManaged public var name: String?
    @NSManaged public var score: Int64
    @NSManaged public var subline: String?
    @NSManaged public var id: String?

}
