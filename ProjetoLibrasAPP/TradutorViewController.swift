//
//  TradutorViewController.swift
//  ProjetoLibrasAPP
//
//  Created by André Rodrigues de Jesus on 10/19/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class TradutorViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate {
    
    var frase = [String?](count: 3, repeatedValue: nil)
    var atual = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frase[0] = ""
        frase[1] = ""
        frase[2] = ""

    }
    
    

    
    
}
