//
//  StartViewController.swift
//  DanceApp
//
//  Created by mac on 26.07.17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var slideScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        slideScrollView.delegate = self
        let slides:[Slide] = createSlides()
        setupSlideScrollView(slides: slides)
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
        self.imageView.image = #imageLiteral(resourceName: "logo")
        self.appNameLabel.text = "Dancely"
        
      
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
//        if(pageIndex == 0) {
//        let buttonBut = UIButton(type: . system)
//        buttonBut.layer.cornerRadius = 25
//        buttonBut.layer.masksToBounds = true
//        buttonBut.backgroundColor = .blue
//        buttonBut.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
//        buttonBut.setTitle("Зарегистрироваться", for: .normal)
//        buttonBut.setTitleColor(.white, for: .normal)
//        buttonBut.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        view.addSubview(buttonBut)
//    }
    }
 
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "startToLogin" {
//            let dvc = segue.destination as? ViewController
//            dvc?.delegate = self
//            
//        }
//    }


    
}
