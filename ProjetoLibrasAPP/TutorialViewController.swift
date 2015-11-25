//
//  TutorialViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 25/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class TutorialViewController: ViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var guideView: UIView!
    
    var currentPage:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.showNavigation()
    }

    override func viewDidLayoutSubviews() {
        initializeScroll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func showMenu(sender: AnyObject) {
        super.showMenu()
    }
    
    func initializeScroll() {
        
        if !(scrollView.subviews.count > 2){
            let scrollViewWidth:CGFloat = guideView.frame.width
            let scrollViewHeight:CGFloat = guideView.frame.height
            
            for i in 1...13{
                let img = UIImageView(frame: CGRect(x: (scrollViewWidth * (CGFloat(i) - 1.0)), y: 0, width: scrollViewWidth, height: scrollViewHeight))
                img.image = UIImage(named: String(i))
                img.contentMode = UIViewContentMode.ScaleAspectFit
                self.scrollView.addSubview(img)
            }
            
            self.scrollView.contentSize = CGSizeMake((self.guideView.frame.width * 13), self.guideView.frame.height)
            self.scrollView.delegate = self
        }
    }
    
    @IBAction func next(sender: AnyObject) {
        if currentPage < 12{
            currentPage += 1
        }
        self.scrollView.scrollRectToVisible(CGRect(x: (scrollView.frame.width * CGFloat(currentPage)), y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
    }
    
    @IBAction func back(sender: AnyObject) {
        if currentPage > 0{
            currentPage -= 1
        }
        self.scrollView.scrollRectToVisible(CGRect(x: (scrollView.frame.width * CGFloat(currentPage)), y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
    }
}
