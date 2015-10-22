//
//  FraseViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Gabriela  Gomes Pires on 22/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreData


class FraseViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array : [String] = []
    var i : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func atualizarTotalDasFrases() -> Int {
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contexto: NSManagedObjectContext = appDelegate.managedObjectContext
        array.removeAll()
        do{
            let request = NSFetchRequest(entityName: "Frase")
            let listaDeFrase = try contexto.executeFetchRequest(request)
            i = listaDeFrase.count
            if listaDeFrase.count > 0{
                for item in listaDeFrase as! [NSManagedObject]{
                    
                    let frase = item.valueForKey("salvaFrase")
                    array.append((frase! as? String)!)
                }
            }
            
        }
        catch{
            print("Erro ao salvar")
        }
        
        return i
    }
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        
        return atualizarTotalDasFrases()
    }
    
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let fraseColoca = array[indexPath.row]
        cell.textLabel?.text = fraseColoca
        
        return cell
    }

    
}
  