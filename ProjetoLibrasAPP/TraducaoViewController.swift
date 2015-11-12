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
    var frases : [[String]] = []
    
    var fraseList = [String?](count: 3, repeatedValue: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTextoDigitadoPassed.text = textoDigitado
        lblTraducaoPassed.text = textoTraduzido
        copiar = UIPasteboard.generalPasteboard()
        coloreFraseSurdo()
        coloreFraseTradutor()
    }
    
    func coloreFraseTradutor(){
        let texto = textoTraduzido
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: texto)
        
        print("tamanho: " + String(texto.characters.count))
        
        var initial = 0
        var final = 0
        
        
        initial = 0
        
        for palavra in frases[3]{
            initial += palavra.characters.count
        }
        
        initial -= frases[3][(frases[3].count - 1)].characters.count
        initial += 1
        final = frases[3][(frases[3].count - 1)].characters.count
            
        myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), range:NSRange(location:initial, length:final))
        
        
        
        initial = 0
        
        for palavra in frases[3]{
            initial += palavra.characters.count + 1
        }
        
        final = frases[4][0].characters.count
        
        myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0), range:NSRange(location:initial, length:final))
        
        
        
        initial = 0
        
        for palavra in frases[3]{
            initial += palavra.characters.count + 1
        }
        
        for palavra in frases[4]{
            initial += palavra.characters.count + 1
        }
        
        final = frases[5][0].characters.count - 1
        
        myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0), range:NSRange(location:initial, length:final))
        
        lblTraducaoPassed.attributedText = myMutableString
    }
    
    func coloreFraseSurdo(){
        let texto = fraseList[0]! + " " + fraseList[1]! + " " + fraseList[2]!
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: texto)
        
        print("tamanho: " + String(texto.characters.count))
        
        var initial = 0
        var final = 0
        
        if (fraseList[0]?.characters.count != 0){
            initial = 0
            final = (fraseList[0]?.characters.count)!
            
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), range:NSRange(location:initial, length:final))
        }
        
        if (fraseList[1]?.characters.count != 0){
            initial = (fraseList[0]?.characters.count)! + 1
            final = (fraseList[1]?.characters.count)!
            
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0), range:NSRange(location:initial, length:final))
        }
        
        if (fraseList[2]?.characters.count != 0){
            initial = (fraseList[0]?.characters.count)! + (fraseList[1]?.characters.count)! + 2
            final = (fraseList[2]?.characters.count)!
            
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0), range:NSRange(location:initial, length:final))
        }
        
        lblTextoDigitadoPassed.attributedText = myMutableString
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
