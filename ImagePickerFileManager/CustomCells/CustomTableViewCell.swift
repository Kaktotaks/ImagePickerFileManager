//
//  CustomTableViewCell.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 27.07.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var timeOfShotingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCoreDataPhotos(with cdPhoto: CDPhoto?, image: UIImage?) {
        photoImageView.image = image
        timeOfShotingLabel.text = cdPhoto?.time
        }
    
}
