//
//  Timer+CoreDataProperties.swift
//  PomoTimer
//
//  Created by Kovs on 20.04.2022.
//
//

import Foundation
import CoreData


extension Timer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timer> {
        return NSFetchRequest<Timer>(entityName: "Timer")
    }

    @NSManaged public var intervals: Int16
    @NSManaged public var isMarked: Bool
    @NSManaged public var minute: Int16
    @NSManaged public var name: String?
    @NSManaged public var seconds: Int16
    @NSManaged public var note: String?

}

extension Timer : Identifiable {

}
