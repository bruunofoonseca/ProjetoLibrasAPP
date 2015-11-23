//
//  TraduzidoViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 23/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreData

class TraduzidoViewController: ViewController {

    @IBOutlet weak var fraseUsuarioLabel: UILabel!
    @IBOutlet weak var fraseTraduzidaLabel: UILabel!
    @IBOutlet weak var tempoVerbalControl: UISegmentedControl!
    
    var frases : [[String]] = []
    var fraseTraduzida : [String] = []
    var fraseUsuario = ""
    
    @IBOutlet weak var viewFraseTraduzida: UIView!
    @IBOutlet weak var viewFraseusuario: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fraseUsuarioLabel.text = fraseUsuario
        selecionaFrase()
        
        customizaViews()
        
        super.showNavigation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        super.showMenu()
    }
    
    /* Muda o tempo verbal da frase */
    
    func selecionaFrase(){
        let index = tempoVerbalControl.selectedSegmentIndex
        
        fraseTraduzidaLabel.text = fraseTraduzida[index]
    }
    
    @IBAction func mudaTempoVerbal(sender: UISegmentedControl) {
        selecionaFrase()
    }
    
    /* Mostra em tela cheia */
    
    @IBAction func showFullScreen(sender: AnyObject) {
        self.performSegueWithIdentifier("ShowFullScreenTradutor", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ShowFullScreenTradutor" {
            
            let svc = segue.destinationViewController as! FullScreenTraducaoViewController
            
            svc.frase = fraseTraduzidaLabel.text!
        }
    }
    
    /* Customiza views */
    
    func customizaViews(){
        viewFraseTraduzida.layer.borderWidth = 1
        viewFraseTraduzida.layer.borderColor = UIColor.blackColor().CGColor
        viewFraseTraduzida.layer.cornerRadius = 5
        
        viewFraseusuario.layer.borderWidth = 1
        viewFraseusuario.layer.borderColor = UIColor.blackColor().CGColor
        viewFraseusuario.layer.cornerRadius = 5
    }
    
    /* Ações dos botoes */
    
    @IBAction func Copiar(sender: AnyObject) {
        var copiar:UIPasteboard
        copiar = UIPasteboard.generalPasteboard()
        copiar.string = fraseTraduzidaLabel.text
        self.view.makeToast(message: "Frase copiada!")
    }
    
    @IBAction func Salvar(sender: AnyObject) {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let request = NSFetchRequest(entityName: "Frase")
        var contSalvarFrase = 0
        let frase = FrasesTableViewController()
        
        var jaSalvou = false
        var arrayDeFrases : [String] = []
        arrayDeFrases.removeAll()
        let contexto: NSManagedObjectContext = appDel.managedObjectContext
        
        
        do{
            let listaDeFrase = try contexto.executeFetchRequest(request)
            
            for item in listaDeFrase as! [NSManagedObject]{
                let fraseLista = item.valueForKey("salvaFrase")
                if(fraseLista != nil){
                    arrayDeFrases.append((fraseLista as? String)!)
                }
                
            }
        }
        catch{
            print("Erro")
        }
        
        for itens in arrayDeFrases{
            if (itens == fraseTraduzidaLabel.text as String!){
                jaSalvou = true
            }
        }
        
        if(!jaSalvou){
            contSalvarFrase = frase.atualizarTotalDasFrases()
            let novaFrase = NSEntityDescription.insertNewObjectForEntityForName("Frase", inManagedObjectContext:contexto)
            novaFrase.setValue(fraseTraduzidaLabel.text, forKey: "salvaFrase")
            novaFrase.setValue(contSalvarFrase - 1, forKey: "orderPosition")
            
            do{
                try contexto.save()
            }
            catch{
                print("Erro ao salvar")
            }
            
            self.view.makeToast(message: "Frase salva!")
        }
        else{
            self.view.makeToast(message: "A frase já existe!")
        }
        
        frase.atualizarTotalDasFrases()
    }
    
    @IBAction func Compartilhar(sender: AnyObject) {
        var meuCompartilhamento:UIActivityViewController
        
        meuCompartilhamento = UIActivityViewController(activityItems: [fraseTraduzidaLabel.text!], applicationActivities: nil)
        meuCompartilhamento.excludedActivityTypes = [UIActivityTypeAirDrop]
        meuCompartilhamento.popoverPresentationController?.sourceView = self.view
        meuCompartilhamento.popoverPresentationController?.sourceRect = sender.frame
        meuCompartilhamento.completionWithItemsHandler = {
            (activity, sucess, items, error) in
            if(sucess == true){
                self.view.makeToast(message: "Frase compartilhada!")
            }
        }
        
        self.presentViewController(meuCompartilhamento, animated: true, completion: nil)
    }
}
