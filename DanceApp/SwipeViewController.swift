//
//  SwipeViewController.swift
//  DanceApp
//
//  Created by mac on 01.08.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import Firebase

class SwipeViewController: UIViewController {
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var danceTypeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var divisor: CGFloat!
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        divisor = (view.frame.width / 2) / 0.61
        fetchUser()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor )
        
        if xFromCenter > 0 {
            thumbImageView.image = #imageLiteral(resourceName: "thumbUp")
            thumbImageView.tintColor = UIColor.green
        } else {
            thumbImageView.image = #imageLiteral(resourceName: "thumbDown")
            thumbImageView.tintColor = UIColor.red
            
        }
        
        thumbImageView.alpha = abs(xFromCenter) / view.center.x
        
        if sender.state == UIGestureRecognizerState.ended {
            
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                return
            } else if card.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                })
                return
            }
            resetCard()
            
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        resetCard()
    }
    
    func resetCard() {
        UIView.animate(withDuration: 0.2, animations:
            {
                self.card.center = self.view.center
                self.thumbImageView.alpha = 0
                self.card.alpha = 1
                self.card.transform = .identity
        })
    }
    
    func fetchUser() {
        
        Database.database().reference().child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                
                for i in dictionary {
                    let user = User()
                    user.setValuesForKeys(i.value as! [String: Any])
                    self.users.append(user)
                }
                self.users.map {
                    self.nameLabel.text = $0.name
                    self.heightLabel.text = $0.height
                    self.danceTypeLabel.text = $0.type
                    
                    if let imageUrl = $0.userImg, let url = URL(string: imageUrl){
                        DispatchQueue.main.async {
                            self.imageView.setImage(from: url)
                        }
                        self.imageView.contentMode = .scaleAspectFill
                        //  print($0.name!)
                    }
                }
            }
            }) { (error) in
                print(error)
            }
            
        }
        
}
