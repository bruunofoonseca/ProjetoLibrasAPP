//
//  FullScreenTraducaoViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 23/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class FullScreenTraducaoViewController: ViewController {

    @IBOutlet weak var fraseLabel: UILabel!
    var frase : String = ""
    
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
