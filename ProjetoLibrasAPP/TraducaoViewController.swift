//
//  TraducaoViewController.swift
//  ProjetoLibrasAPP
//
//  Created by André Rodrigues de Jesus on 11/2/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit
import Social
import CoreData

class TraducaoViewController: UIViewController {
    
    @IBOutlet weak var lblTextoDigitadoPassed: UILabel!
    @IBOutlet weak var lblTraducaoPassed: UILabel!
    @IBOutlet weak var btnCopiar: UIButton!
    @IBOutlet weak var btnCompartilhar: UIButton!
    @IBOutlet weak var signWritingSalvar: UIImageView!
    var meuCompartilhamento:UIActivityViewController!
    
    var textoDigitado: String!
    var textoTraduzido: String!
    var contSalvarFrase = 0
    var copiar:UIPasteboard!
    var frase = FraseViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTextoDigitadoPassed.text = textoDigitado
        lblTraducaoPassed.text = textoTraduzido
        copiar = UIPasteboard.generalPasteboard()
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func btnCopiarAction(sender: AnyObject) {
        
        copiar.string = lblTraducaoPassed.text
        self.view.makeToast(message: "Frase copiada!")
    }
    
    @IBAction func btnCompartilharAction(sender: AnyObject) {
        meuCompartilhamento = UIActivityViewController(activityItems: [lblTraducaoPassed.text!], applicationActivities: nil)
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
    
    @IBAction func btnSalvarAction(sender: AnyObject) {
        signWritingSalvar.alpha = 1.0
        
        contSalvarFrase = frase.atualizarTotalDasFrases()
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contexto: NSManagedObjectContext = appDel.managedObjectContext
        let novaFrase = NSEntityDescription.insertNewObjectForEntityForName("Frase", inManagedObjectContext:contexto)
        novaFrase.setValue(lblTraducaoPassed.text, forKey: "salvaFrase")
        novaFrase.setValue(contSalvarFrase - 1, forKey: "orderPosition")
        
        do{
            try contexto.save()
        }catch{
            print("Erro ao salvar")
        }
        
        frase.atualizarTotalDasFrases()
        self.view.makeToast(message: "Frase salva!")
    }
    
    @IBAction func btnSalvarActionDown(sender: AnyObject) {
        signWritingSalvar.alpha = 0.5
    }
    
    @IBAction func btnSalvarActionDrag(sender: AnyObject) {
        signWritingSalvar.alpha = 1.0
    }
    
    
    
}
