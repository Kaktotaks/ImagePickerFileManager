//
//  ImagePathRealm.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 12.08.2022.
//

import Foundation
import RealmSwift

class ImageRealmModel: Object {
    @objc dynamic var imagePath: String? = ""
}
