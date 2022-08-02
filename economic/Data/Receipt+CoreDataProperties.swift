//
//  Receipt+CoreDataProperties.swift
//  economic
//
//  Created by José Rodrigues on 02/08/2022.
//
//

import Foundation
import CoreData


extension Receipt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var currency: String?
    @NSManaged public var date: Date?
    @NSManaged public var details: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var title: String?
    @NSManaged public var totalValue: Double
    @NSManaged public var type: String?

}

extension Receipt : Identifiable {

}
