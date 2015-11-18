//
//  FrasesViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 17/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class FrasesViewController: ViewController, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        super.showMenu()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("Frase")!
        
        return cell
    }

}
