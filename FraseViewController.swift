//
//  FraseViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Gabriela  Gomes Pires on 22/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreData


class FraseViewController : UITableViewController {
    
    var array : [String] = []
    var arrayTableView: [String] = []
    var i : Int = 0
    
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
    
    override func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        
        return atualizarTotalDasFrases()
    }
    
    override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        for item in array.reverse(){
            arrayTableView.append(item)
        }
        let fraseColoca = arrayTableView[indexPath.row]
        cell.textLabel?.text = fraseColoca
        
        return cell
    }

    
}
  