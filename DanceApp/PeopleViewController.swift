//
//  PeopleViewController.swift
//  DanceApp
//
//  Created by mac on 28.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
 var food = Food.loadData()
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
        
    }
    
}
extension PeopleViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return food.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return food[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseId", for: indexPath) as! ImageLabelCollectionViewCell
        cell.imageView.image = food[indexPath.section][indexPath.item].image
        cell.imageView.contentMode = .scaleAspectFill
        cell.nameLabel.text = food[indexPath.section][indexPath.item].name
        
        
        return cell
    }
}

