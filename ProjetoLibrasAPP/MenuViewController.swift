//
//  MenuViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 17/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showTraducao(sender: AnyObject) {
        performSegueWithIdentifier("ShowTradutor", sender: self)
    }
    
    @IBAction func showPesquisa(sender: AnyObject) {
        performSegueWithIdentifier("ShowFrases", sender: self)
    }
    
    @IBAction func showExplicacao(sender: AnyObject) {
        performSegueWithIdentifier("ShowVideos", sender: self)
    }
    
    func hideNavigation(){
        self.navigationController?.navigationBar.hidden = true
    }

}
