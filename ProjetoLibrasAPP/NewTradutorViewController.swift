//
//  NewTradutorViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 01/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class NewTradutorViewController: UIViewController {
    
    @IBOutlet var MainView: UIView!
    @IBOutlet weak var MenuView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ShowMenu(sender: UIButton) {
        MainView.bringSubviewToFront(MenuView)
    }
    
    @IBAction func HideMenu(sender: UIButton) {
        MainView.sendSubviewToBack(MenuView)
    }
}
