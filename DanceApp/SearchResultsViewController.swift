//
//  SearchResultsViewController.swift
//  Pods
//
//  Created by mac on 28.07.17.
//
//

import UIKit

class SearchResultsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    var food = Food.loadData()
    var clickedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
       self.collectionView.dataSource = self
        self.layout.minimumLineSpacing = 1
        self.layout.minimumInteritemSpacing = 1
        let size = (self.view.frame.width - 2) / 3
        self.layout.itemSize = CGSize(width: size, height: size)

    }

}
extension SearchResultsViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return food.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return food[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseId", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = food[indexPath.section][indexPath.item].image
        cell.imageView.contentMode = .scaleAspectFill
        
        
        return cell
    }
}
extension SearchResultsViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickedIndexPath = indexPath
        performSegue(withIdentifier: "svc", sender: self)
    }
    

    
}
