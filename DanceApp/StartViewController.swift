//
//  StartViewController.swift
//  DanceApp
//
//  Created by mac on 26.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class StartViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var slideScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var logInButton: UIButton!

    
    @IBOutlet weak var logoAppnameImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.logInButton.layer.borderWidth = 2
        //self.logInButton.layer.borderColor = UIColor.black.cgColor
        
        self.logInButton.layer.borderColor = UIColor.init(red: 0.2510, green: 0.5137, blue: 1.0000, alpha: 0.9).cgColor
        slideScrollView.delegate = self
        let slides:[Slide] = createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
        self.logoAppnameImageView.image = #imageLiteral(resourceName: "Groupyellow2")
      
        
      
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
   
    func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.label.text = "Найти партнера / партнершу по танцам"
       
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.label.text = "Научиться красиво танцевать"
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.label.text = "Создать свою группу"
        return [slide1, slide2, slide3]
    }
    
    func setupSlideScrollView(slides:[Slide]){
        slideScrollView.frame = CGRect(x: 0, y: 408, width: view.frame.width, height: 46)
       
        slideScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height-621)
        slideScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            slideScrollView.addSubview(slides[i])
        }
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
