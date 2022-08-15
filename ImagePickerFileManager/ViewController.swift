//
//  ViewController.swift
//  ImagePickerFileManager
//
//  Created by Леонід Шевченко on 27.07.2022.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var photosList = Photos.photosList
    var imagePicker: UIImagePickerController!
    var imageName = 1
    var coreDataPhotosList: [CDPhoto]?
    let manager = LocalFileManager.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "camera"), style: .plain, target: self, action: #selector(takePhoto))
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
        
        do {
            manager.saveImage(
                image: image,
                name: "\(imageName)")
            photosList.append(Photo(
                photoImage: manager.getImage(name: "\(imageName)"),
                photoTime: Date.getCurrentUADate(.now)()))
        } catch {
            print("Error while saveng an image after ImagePicker")
        }
        
        imageName += 1
        tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else { return UITableViewCell() }
        
        cell.configurePhoto(photosList[indexPath.row])
//        cell.photoImageView.image = loadImageFromDiskWith(fileName: "Photo \(IndexSet())")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  240
    }
}

