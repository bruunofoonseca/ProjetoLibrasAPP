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
        
        navigationTranparente()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showTraducao(sender: AnyObject) {
        performSegueWithIdentifier("ShowVideos", sender: self)
    }
    
    @IBAction func showPesquisa(sender: AnyObject) {
        performSegueWithIdentifier("ShowFrases", sender: self)
    }
    
    @IBAction func showExplicacao(sender: AnyObject) {
        performSegueWithIdentifier("ShowTradutor", sender: self)
    }
    
    func navigationTranparente(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
    }
}
