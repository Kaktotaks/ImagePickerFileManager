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
    var photos: [UIImage] = []
    
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
    
    var image = UIImage()
    
    // Add the photo to the tableView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
        print("No image found")
        return
    }
    
        self.image = saveImage(image: image)
        photosList.append(Photo(photoImage: self.image))
        

        tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func saveImage(image: UIImage) -> UIImage {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

        let fileURL = documentsDirectory?.appendingPathComponent("Photo \(IndexSet())")
        let data = image.jpegData(compressionQuality: 1) ?? image.pngData()


        do {
            try data!.write(to: fileURL!)
        } catch let error {
            print("error saving file with error", error)
        }
        
        return image
    }



    func loadImageFromDiskWith(fileName: String) -> UIImage? {

      let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image

        }

        return nil
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell else { return UITableViewCell() }
        
        cell.configurePhoto(photosList[indexPath.row])
        cell.photoImageView.image = loadImageFromDiskWith(fileName: "Photo \(IndexSet())")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  240
    }
}

