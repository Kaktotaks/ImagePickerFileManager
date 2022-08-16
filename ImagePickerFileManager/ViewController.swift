//
//  ViewController.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 27.07.2022.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    static let shared = ViewController()
    @IBOutlet weak var tableView: UITableView!
    var imagePicker: UIImagePickerController!
    var imageName = 1
    var cdPhotos: [CDPhoto]?
    var photo: Photo? = nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let manager = LocalFileManager.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "camera"), style: .plain, target: self, action: #selector(takePhoto))
        
        fetchPhotos()
    }
    
    func fetchPhotos() {
       // Fetch data from Core Data to displayin the table View
        do {
            self.cdPhotos = try context.fetch(CDPhoto.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print("An error while fetching some data from Core Data")
        }
        
   }
    
    @objc func takePhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self;
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    // Add the photo to the tableView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
        print("No image found")
        return
    }
        
            manager.saveImage(
                image: image,
                name: "\(imageName)")
            
            // Create a photo object
            let newPhoto = CDPhoto(context: self.context)
            newPhoto.time = Date.getCurrentUADate(.now)()
            newPhoto.path = LocalFileManager.instance.getPathForImage(name: "\(imageName)")?.description
            
            // Save the data
            do {
                try self.context.save()
            } catch {
                print("An error while saving context")
            }
            
            // Re-fetch data
        self.fetchPhotos()
        
        imageName += 1
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cdPhotos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else { return UITableViewCell() }
        
        // MARK: - Configure CoreData entities to a cell entities
        guard
            let photo = self.cdPhotos?[indexPath.row] else { return UITableViewCell() }
        cell.timeOfShotingLabel.text = photo.time
        cell.photoImageView.image = LocalFileManager.instance.getImage(name: (photo.path!))

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  240
    }
}

