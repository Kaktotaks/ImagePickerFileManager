//
//  LocalFileManager.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 12.08.2022.
//

import Foundation
import UIKit

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        guard
            let data = image.jpegData(compressionQuality: 1) ?? image.pngData(),
            let path = getPathForImage(name: name)
        else {
            print("Error getting data.")
            return
        }

        do {
           try data.write(to: path)
            print(path)
            print("Success saving!")
        } catch let error {
            print("Error in saving data in LocalFile! \(error) ")
        }
        
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path)
        else {
            print("Error getting path to an Image.")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).jpeg")
        else {
            print("Error getting path")
            return nil
        }
        
        return path
    }
}
