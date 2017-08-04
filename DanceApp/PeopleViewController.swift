//
//  PeopleViewController.swift
//  DanceApp
//
//  Created by mac on 28.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Firebase


class PeopleViewController: UIViewController {
    var food = Food.loadData()
    var users = [User]()
    var clickedIndexPath: IndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.layout.minimumLineSpacing = 1
        self.layout.minimumInteritemSpacing = 1
        let size = (self.view.frame.width - 2) / 2
        self.layout.itemSize = CGSize(width: size, height: 300)
        
        fetchUser()
        
    }
    
    func fetchUser() {
        
        Database.database().reference().child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                
                for i in dictionary {
                    let user = User()
                    user.setValuesForKeys(i.value as! [String: Any])
                    self.users.append(user)
                }
                print(self.users.count)
                print(self.users)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }) { (error) in
            print(error)
        }
        
    }
    
}
extension PeopleViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return users.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseId", for: indexPath) as! ImageLabelCollectionViewCell
        // cell.imageView.image = users[indexPath.item].image
        let user = users[indexPath.item]
       // cell.imageView.contentMode = .scaleAspectFill
        cell.nameLabel.text = user.name
        
        
        return cell
    }
}

