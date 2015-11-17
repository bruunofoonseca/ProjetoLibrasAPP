//
//  ViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 17/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//  
//  ESTA É A VIEW DE BASE APAR CRIAR AS OUTRAS VIEWS (CEM EXCEÇÃO DA VIEW DO MENU)

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showMenu(){
        let menuViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Menu")
        UIApplication.sharedApplication().keyWindow?.rootViewController = menuViewController
    }
}
