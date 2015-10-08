//
//  Front.swift
//  ProjetoLibrasAPP
//
//  Created by André Rodrigues de Jesus on 10/7/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Front:UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var frase: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var frameView: UIView!
    @IBOutlet weak var lblSujeito: UILabel!
    @IBOutlet weak var lblVerbo: UILabel!
    @IBOutlet weak var lblComplemento: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frase.becomeFirstResponder()
        
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        frase.text = "Digite o Sujeito"
        lblSujeito.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
        
        
        let viewSujeito = UIView(frame: CGRectMake(0, 0, scrollViewWidth, scrollViewHeight))
        viewSujeito.backgroundColor = UIColor.blackColor()
        let viewVerbo = UIView(frame: CGRectMake(scrollViewWidth, 0, scrollViewWidth, scrollViewHeight))
        viewVerbo.backgroundColor = UIColor.redColor()
        let viewComplemento = UIView(frame: CGRectMake(scrollViewWidth*2, 0, scrollViewWidth, scrollViewHeight))
        viewComplemento.backgroundColor = UIColor.greenColor()
        
        self.scrollView.addSubview(viewSujeito)
        self.scrollView.addSubview(viewVerbo)
        self.scrollView.addSubview(viewComplemento)
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width*3, self.scrollView.frame.height)
        self.scrollView.delegate = self
                
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage:CGFloat = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1
        
        if Int(currentPage) == 0{
            
            frase.text = "Digite o Sujeito"
            lblSujeito.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
            lblVerbo.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            lblComplemento.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            
        }
        else if Int(currentPage) == 1{
            frase.text = "Digite o Verbo"
            lblVerbo.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
            lblSujeito.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            lblComplemento.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
        }
        else if Int(currentPage) == 2{
            frase.text = "Digite o Complemento"
            lblComplemento.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
            lblSujeito.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            lblVerbo.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
        }
    }
}