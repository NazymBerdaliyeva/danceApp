//
//  KolodaViewController.swift
//  DanceApp
//
//  Created by mac on 02.08.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Koloda
import Firebase

class KolodaViewController: UIViewController {
    
    var users = [User]()
    var cards = [KolodaCardView]()
    private let cardWidth = CGFloat(250)
    private let cardHeight = CGFloat(300)
    
    var previousValue: CGFloat = 0
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    var dataSource = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        self.navigationController?.navigationBar.topItem?.title = "";
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
                
                self.cards = self.users.map {
                    let cardView = KolodaCardView()
                    
                    cardView.nameLabel.text = $0.name
                    cardView.heightLabel.text = $0.height
                    cardView.danceTypeLabel.text = $0.type
                    
                    if let imageUrl = $0.userImg, let url = URL(string: imageUrl){
                        DispatchQueue.main.async {
                            cardView.imageView.setImage(from: url)
                        }
                        cardView.imageView.contentMode = .scaleAspectFill
                    }
                    self.cards.append(cardView)
                    
                    return cardView
                }
                self.kolodaView.reloadData()
            }
        }) { (error) in
            print(error)
        }
        
    }
}
extension KolodaViewController: KolodaViewDelegate {
    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
        let cardView = cards[kolodaView.currentCardIndex]
            if direction == .right {
                cardView.likeImageView.alpha = finishPercentage
//                print("apple")
                cardView.likeImageView.image = #imageLiteral(resourceName: "thumbUp")
                cardView.likeImageView.tintColor = UIColor.green
            } else if direction == .left {
                cardView.likeImageView.alpha = finishPercentage
//                print("cherry")
                cardView.likeImageView.image = #imageLiteral(resourceName: "thumbDown")
                cardView.likeImageView.tintColor = UIColor.red
            }
            else {
                cardView.likeImageView.alpha = 0
                kolodaView?.revertAction()
            }
            cardView.likeImageView.alpha = 1
    }
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
//        print("Out of stock!!")
        self.kolodaView.resetCurrentCardIndex()
        cards.forEach({ (card) in
            card.likeImageView.alpha = 0
        })
      
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaDidResetCard(_ koloda: KolodaView) {
        let cardView = cards[kolodaView.currentCardIndex]
        cardView.likeImageView.alpha = 0
    }
}

extension KolodaViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return cards.count
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        // FIXME: make it via array
        return cards[index]
    }
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return nil
    }
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }
    
}

extension UIImageView {
    func setImage(from url: URL) {
        let urlSession = URLSession(configuration: .default)
        urlSession.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                //DispatchQueue.main.async {
                self.image = UIImage(data: data)
                //}
                
            }
            }.resume()
    }
}


class KolodaCardView: UIView {
 
    // FIXME: Frames
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "baursak")
       // imageView.backgroundColor = .white
        imageView.frame = CGRect(x: 0, y: 0, width: 323, height: 494)
        return imageView
    }()
    
    lazy var likeImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = #imageLiteral(resourceName: "thumbUp")
        
        imageView.frame = CGRect(x: 100, y: 100, width: 128, height: 128)
        return imageView
    }()
    
    let nameLabel = UILabel()
    let heightLabel = UILabel()
    let danceTypeLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        //label.text = "asd"
        nameLabel.frame = CGRect(x: 0, y: 404, width: 195, height: 45)
        heightLabel.frame = CGRect(x: 196, y: 404, width: 130, height: 45)
        danceTypeLabel.frame = CGRect(x: 0, y: 449, width: 325, height: 45)
        nameLabel.textColor = .white
        heightLabel.textColor = .white
        danceTypeLabel.textColor = .white
        likeImageView.alpha = 0
        self.addSubview(imageView)
        self.addSubview(likeImageView)
        self.addSubview(nameLabel)
        self.addSubview(heightLabel)
        self.addSubview(danceTypeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
