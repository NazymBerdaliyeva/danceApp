//
//  UpoloadPicViewController.swift
//  DanceApp
//
//  Created by mac on 31.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import SwiftKeychainWrapper

class UpoloadPicViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var completeSignInBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    @IBAction func selectedImagePicker(_ sender: Any){
        present(imagePicker, animated: true, completion: nil)
    }
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    var array: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.collectionView.dataSource = self
        self.layout.minimumLineSpacing = 1
        self.layout.minimumInteritemSpacing = 1
        let size = (self.view.frame.width - 1) / 2
        self.layout.itemSize = CGSize(width: size, height: size)
        self.navigationController?.navigationBar.topItem?.title = "";
    }
    
    func keychain() {
        guard let currentUser = Auth.auth().currentUser else { return }
        KeychainWrapper.standard.set(currentUser.uid, forKey: "uid")
    }
    func setUpUser(img: String){
        guard let currentUser = Auth.auth().currentUser else { return }
        //keychain()
        
        Database.database().reference().root.child("users").child(currentUser.uid).updateChildValues(["userImg": img])
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            self.array.append(image)
            imageSelected = true
            guard let currentUser = Auth.auth().currentUser else { return }
            if let imgData = UIImageJPEGRepresentation(image, 0.2){
                let metadata = StorageMetadata()
                metadata.contentType = "img/jpeg"
                
                Storage.storage().reference().child(currentUser.uid).putData(imgData, metadata: metadata){
                    (metadata, error) in
                    if error != nil {
                        print("did not upload img")
                    } else {
                        print("uploaded")
                        self.collectionView.reloadData()
                        let downloadURL = metadata?.downloadURL()?.absoluteString
                        if let url  = downloadURL {
                            self.setUpUser(img: url)
                        }
                    }
                }
            }
        }
        else {
            print("Image wasnt selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension UpoloadPicViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count > 0 ? array.count : 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rId", for: indexPath) as! ImageVideoCollectionViewCell
        if array.count > 0 {
            cell.imageView.image = array[indexPath.item]
            cell.imageView.contentMode = .scaleAspectFill
        }
        else {
            print("mistake!")
        }
        return cell
    }
}
