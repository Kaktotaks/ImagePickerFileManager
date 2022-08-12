//
//  CustomTableViewCell.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 27.07.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
   func configurePhoto(_ photo: Photo) {
       photoImageView.image = photo.photoImage
    }
    
}
