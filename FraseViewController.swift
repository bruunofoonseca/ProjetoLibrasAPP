
//
//  FraseViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Gabriela  Gomes Pires on 22/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreData


class FraseViewController : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredSentences = [String]()
    var searchActive : Bool = false
    
    var array : [String] = []
    var arrayTableView: [String] = []
    var i : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup delegates */
        searchBar.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        searchBar.resignFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        searchBar.resignFirstResponder()
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
    
    override func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        
        if(searchActive) {
            return filteredSentences.count
        }
        
        return atualizarTotalDasFrases()
    }
    
    override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        for item in array.reverse(){
            arrayTableView.append(item)
        }
        var fraseColoca:String
        
        if(searchActive){
            fraseColoca = filteredSentences[indexPath.row]
        } else {
            fraseColoca = arrayTableView[indexPath.row]
        }
        
        cell.textLabel?.text = fraseColoca
        
        return cell
    }
    
    // Search bar =====================
    
//    func filterContentForSearchText(searchText: String) {
//        // Filter the array using the filter method
//        
//        self.filteredSentences = self.array.filter({( sentence: String) -> Bool in
//            
//            let stringMatch = sentence.lowercaseString.rangeOfString(searchText.lowercaseString)
//            return stringMatch != nil ? true : false
//        })
//    }
//    
//    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String?) -> Bool {
//        self.filterContentForSearchText(searchString!)
//        return true
//    }
//    
//    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
//        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text!)
//        return true
    //    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredSentences = self.array.filter({( sentence: String) -> Bool in
            let stringMatch = sentence.lowercaseString.rangeOfString(searchText.lowercaseString)
            return stringMatch != nil ? true : false
        })
        
        if(filteredSentences.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        
        self.tableView.reloadData()
    }

    
}
  