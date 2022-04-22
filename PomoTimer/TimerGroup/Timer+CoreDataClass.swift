//
//  Timer+CoreDataClass.swift
//  PomoTimer
//
//  Created by Kovs on 20.04.2022.
//
//

import Foundation
import CoreData


public class Timer: NSManagedObject {
    @NSManaged var intervals: Int
    @NSManaged var minute: Int
    @NSManaged public var seconds: Int16
}
