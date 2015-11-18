//
//  FraseViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 18/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class ShowFraseViewController: ViewController {

    var frase:String = ""
    @IBOutlet weak var fraseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fraseLabel.text = frase
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        super.showMenu()
    }
}
