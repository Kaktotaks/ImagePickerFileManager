//
//  CDPhoto+CoreDataProperties.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 17.08.2022.
//
//

import Foundation
import CoreData

extension CDPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPhoto> {
        return NSFetchRequest<CDPhoto>(entityName: "CDPhoto")
    }

    @NSManaged public var time: String?
    @NSManaged public var imageName: UUID?
}

extension CDPhoto : Identifiable {

}
