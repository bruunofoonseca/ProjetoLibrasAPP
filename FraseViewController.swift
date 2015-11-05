//  FraseViewController.swift
//  ProjetoLibrasAPP
//  Created by Gabriela  Gomes Pires on 22/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.

import UIKit
import CoreData

class FraseViewController : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let request = NSFetchRequest(entityName: "Frase")
    
    let sortDescriptor = NSSortDescriptor(key: "orderPosition", ascending: true)
    
    var filteredSentences = [String]()
    
    var searchActive : Bool = false
    
    var deletarFraseIndexPath: NSIndexPath? = nil
    
    var array : [String] = []
    
    var arrayTableView: [String] = []
    
    var i : Int = 0
    
    var ativo = false
    
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    
    
    /********** MÉTODOS ATUALIZA E COLOCA AS FRASES NO ARRAY  **********/
    
    
    
    func atualizarTotalDasFrases() -> Int {
        
        
        
        let contexto: NSManagedObjectContext = appDelegate.managedObjectContext
        
        array.removeAll()
        
        do{
            
            request.sortDescriptors = [sortDescriptor]
            
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
    
    
    
    
    
    /********** MÉTODO PARA MOVER A TABLE VIEW  **********/
    
    
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
        
    }
    
    
    
    /********** MÉTODO QUE RETORNA A QUANTIDADE DE CELLS  **********/
    
    
    
    override func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        
        
        
        if(searchActive) {
            
            return filteredSentences.count
            
        }
        
        
        
        return atualizarTotalDasFrases()
        
    }
    
    
    
    /********** MÉTODO QUE COLOCA OS VALORES EM CADA CELL  **********/
    
    
    
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
    
    
    
    /********** MÉTODO RESPONSÁVEL PELA AÇÃO DE MOSTRAR OS BOTÕES DELETAR E MOVER  **********/
    
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        
        
        /********** BOTÃO DELETAR  **********/
        
        
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: "        "){
            
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            self.request.returnsObjectsAsFaults = false
            
            self.deletarFraseIndexPath = indexPath
            
            self.confirmDelete()
            
            
            
        }
        
        
        
        
        
        deleteAction.backgroundColor = UIColor(patternImage: UIImage(named: "excluir")!)
        
        
        
        
        
        /********** BOTÃO MOVER  **********/
        
        
        
        
        
        let moverAction = UITableViewRowAction(style: .Normal, title: "        "){
            
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            self.editing = false
            
            if(!self.ativo){
                
                self.moverCell()
                
                self.ativo = true
                
            }
                
            else{
                
                self.editing = false
                
                self.ativo = false
                
            }
            
        }
        
        moverAction.backgroundColor = UIColor(patternImage: UIImage(named: "mover")!)
        
        return [deleteAction, moverAction]
        
        
        
    }
    
    
    
    /********** MÉTODO CHAMADO PELO BOTÃO MOVER, LIBERA O EDITBUTTOM  **********/
    
    
    
    func moverCell(){
        
        self.editing = true
        
    }
    
    
    
    
    
    /********** MÉTODO RESPONSÁVEL POR SALVAR A REORDENAÇÃO DA TABLE VIEW NO CORE DATA  **********/
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        let val = self.arrayTableView.removeAtIndex(fromIndexPath.row)
        
        
        
        // insert it into the new position
        
        self.arrayTableView.insert(val, atIndex: toIndexPath.row)
        
        
        
        do {
            
            let contxt: NSManagedObjectContext = self.appDelegate.managedObjectContext
            
            request.sortDescriptors = [sortDescriptor]
            
            let MyData = try contxt.executeFetchRequest(request)
            
            var count = toIndexPath.row
            
            if fromIndexPath.row > toIndexPath.row
                
            {
                
                for _ in toIndexPath.row...(fromIndexPath.row - 1)
                    
                    
                    
                {
                    
                    MyData[MyData.count - 1 - count].setValue(MyData.count - count-2, forKey: "orderPosition")
                    
                    count++
                    
                    
                    
                }
                
                
                
                MyData[MyData.count - count - 1].setValue(MyData.count - 1 - toIndexPath.row, forKey: "orderPosition")
                
            }
            
            
            
            if fromIndexPath.row < toIndexPath.row
                
            {
                
                
                
                for _ in fromIndexPath.row...(toIndexPath.row - 1)
                    
                    
                    
                {
                    
                    MyData[MyData.count - 1 - count].setValue(MyData.count - count, forKey: "orderPosition")
                    
                    count--
                    
                    
                    
                }
                
                
                
                MyData[MyData.count - 1 - fromIndexPath.row].setValue(MyData.count - 1 - toIndexPath.row, forKey: "orderPosition")
                
                
                
            }
            
            
            
            do{
                
                try contxt.save()
                
            }
                
            catch{
                
                print("erro ao salvar no core data")
                
            }
            
            
            
        }
            
        catch{
            
            print("erro")
            
        }
        
    }
    
    
    
    /********** MÉTODO PARA CONFIRMAR A DELEÇÃO DA FRASE E ATUALIZA A EXCLUSÃO NO CORE DATA  **********/
    
    
    
    func confirmDelete() {
        
        let alert = UIAlertController(title: "Deletar Frase", message: "Você tem certeza que deseja deletar?", preferredStyle: .ActionSheet)
        
        
        
        let DeleteAction = UIAlertAction(title: "Deletar", style: .Destructive, handler: confirmaDeletar)
        
        let CancelAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: cancelaDeletar)
        
        
        
        alert.addAction(DeleteAction)
        
        alert.addAction(CancelAction)
        
        
        
        // Support display in iPad
        
        alert.popoverPresentationController?.sourceView = self.view
        
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    func confirmaDeletar(alertAction: UIAlertAction!) -> Void {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        self.request.returnsObjectsAsFaults = false
        
        if let indexPath = deletarFraseIndexPath {
            
            do{
                
                self.arrayTableView.removeAtIndex(indexPath.row)
                
                let incidents = try context.executeFetchRequest(self.request)
                
                var value : Int = incidents.count
                
                value = value - indexPath.row - 1
                
                let deletar = incidents[value]
                
                context.deleteObject(deletar as! NSManagedObject)
                
                do {
                    
                    try context.save()
                    
                }
                
            }
                
            catch{
                
                print("error")
                
            }
            
            
            
            self.tableView.reloadData()
            
        }
        
    }
    
    
    
    /********** MÉTODO QUE CANCELA A EXCLUSÃO DA FRASE  **********/
    
    
    
    func cancelaDeletar(alertAction: UIAlertAction!) {
        
        deletarFraseIndexPath = nil
        
    }
    
    
    
    
    
    /********** MÉTODO DE PESQUISA DAS FRASES  **********/
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.managedObjectContext
            request.returnsObjectsAsFaults = false
            
            do{
                arrayTableView.removeAtIndex(indexPath.row)
                let incidents = try context.executeFetchRequest(request)
                let deletar = incidents[indexPath.row]
                context.deleteObject(deletar as! NSManagedObject)
            }
            catch{
                print("error")
            }
            
            self.tableView.reloadData()
        }
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

  