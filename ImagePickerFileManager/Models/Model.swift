//
//  Model.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 27.07.2022.
//

import Foundation
import UIKit

class Photos {
    static var photosList: [Photo] = [Photo(photoImage: UIImage(named: "dorado"), photoTime: Date.getCurrentUADate(.now)())]
}


struct Photo {
    var photoImage: UIImage?
    var photoTime: String?
}
