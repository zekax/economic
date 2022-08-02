//
//  Receipt+CoreDataProperties.swift
//  economic
//
//  Created by José Rodrigues on 31/07/2022.
//
//

import Foundation
import CoreData


extension Receipt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var totalValue: Decimal
    @NSManaged public var currency: String?
    @NSManaged public var date: Date?
    @NSManaged public var type: String?
    @NSManaged public var imagePath: String?

}

extension Receipt : Identifiable {

}
