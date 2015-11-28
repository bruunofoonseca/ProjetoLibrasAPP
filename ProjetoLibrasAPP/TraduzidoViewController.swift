//
//  TraduzidoViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 23/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class TraduzidoViewController: ViewController {
    
    @IBOutlet weak var fraseUsuarioLabel: UILabel!
    @IBOutlet weak var fraseTraduzidaLabel: UILabel!
    @IBOutlet weak var tempoVerbalControl: UISegmentedControl!
    
    var frases : [[String]] = []
    var fraseTraduzida : [String] = []
    var fraseUsuario = ""
    var fraseList = [String?](count: 3, repeatedValue: nil)
    
    @IBOutlet weak var viewFraseTraduzida: UIView!
    @IBOutlet weak var viewFraseusuario: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fraseUsuarioLabel.text = fraseUsuario
        selecionaFrase()
        
        customizaViews()
        
        super.showNavigation()
        
        coloreFraseSurdo()
        coloreFraseTradutor()
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
        
        coloreFraseSurdo()
        coloreFraseTradutor()
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
        viewFraseTraduzida.layer.borderColor = UIColor(red:220/255.0, green:220/255.0, blue:220/255.0, alpha:1.0).CGColor
        viewFraseTraduzida.layer.cornerRadius = 5
        
        viewFraseusuario.layer.borderWidth = 1
        viewFraseusuario.layer.borderColor = UIColor(red:220/255.0, green:220/255.0, blue:220/255.0, alpha:1.0).CGColor
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
            debugPrint("Erro")
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
                debugPrint("Erro ao salvar")
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
    
    @IBAction func Falar(sender: AnyObject) {
        let synt: AVSpeechSynthesizer = AVSpeechSynthesizer()
        
        let nextSpeach:AVSpeechUtterance = AVSpeechUtterance(string: fraseTraduzidaLabel.text!)
        nextSpeach.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        
        let os = NSProcessInfo().operatingSystemVersion
        switch (os.majorVersion){
        case 8:
            nextSpeach.rate = 0
            break
        default:
            nextSpeach.rate = 0.42
            break
        }
        
        synt.speakUtterance(nextSpeach)
        
        self.view.makeToast(message: "Falando frase")
    }
    
    /* Colore frases */
    
    func coloreFraseSurdo(){
        let texto = fraseList[0]! + " " + fraseList[1]! + " " + fraseList[2]!
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: texto)
        
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
        
        fraseUsuarioLabel.attributedText = myMutableString
    }
    
    func coloreFraseTradutor(){
        
        if(frases == []){
            coloreIgual()
        }else{
            var sujeito:Int = 0, verbo:Int = 0, complemento:Int = 0
            
            let tempoVerbal = tempoVerbalControl.selectedSegmentIndex
            
            if (tempoVerbal == 1){
                sujeito = 0
                verbo = 1
                complemento = 2
            }else if(tempoVerbal == 0){
                sujeito = 3
                verbo = 4
                complemento = 5
            }else if(tempoVerbal == 2){
                sujeito = 6
                verbo = 7
                complemento = 8
            }
            
            let texto = fraseTraduzidaLabel.text
            
            var myMutableString = NSMutableAttributedString()
            myMutableString = NSMutableAttributedString(string: texto!)
            
            var initial = 0
            var final = 0
            
            // Sujeito
            initial = 0
            for palavra in frases[sujeito]{
                if (palavra != "null" && !palavra.isEmpty) {
                    initial += palavra.characters.count + 1
                }
            }
            initial -= 1
            if (initial > 0){
                initial -= frases[sujeito][(frases[sujeito].count - 1)].characters.count
            }
            
            final = frases[sujeito][(frases[sujeito].count - 1)].characters.count
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), range:NSRange(location:initial, length:final))
            
            
            
            // Verbo
            initial = 0
            for palavra in frases[sujeito]{
                if (palavra != "null" && !palavra.isEmpty) {
                    initial += palavra.characters.count + 1
                }
            }
            
            final = frases[verbo][0].characters.count
            
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0), range:NSRange(location:initial, length:final))
            
            // Complemento
            initial = 0
            for palavra in frases[sujeito]{
                if (palavra != "null" && !palavra.isEmpty) {
                    initial += palavra.characters.count + 1
                }
            }
            for palavra in frases[verbo]{
                if (palavra != "null" && !palavra.isEmpty) {
                    initial += palavra.characters.count + 1
                }
            }
            
            
            if Array(texto!.characters)[(texto!.characters.count - 2)] == "."{
                if (frases[complemento].count == 1) && (frases[verbo][1] != " ") && (frases[verbo][1] != ""){
                    initial -= 1
                }
                else if(frases[complemento].count == 1) && (frases[verbo][1] != " ") && (frases[verbo][1] != ""){
                    initial += 1
                }
                else if (frases[complemento].count > 1) && (frases[verbo][1] != " ") && (frases[complemento][0].characters.count == 1){
                    initial -= -1
                }
                else if (frases[complemento].count > 1) && (frases[complemento][0].characters.count > 1){
                    initial += 2
                }
                else if(frases[verbo][1] == ""){
                    initial -= 1
                }
                else{
                    initial -= 2
                }
            }
            else{
                initial -= 2
            }
            
            final = frases[complemento][(frases[complemento].count - 1)].characters.count
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0), range:NSRange(location:initial, length:final))
            
            
            fraseTraduzidaLabel.attributedText = myMutableString
        }
    }
    
    func coloreIgual(){
        let texto = fraseTraduzidaLabel.text
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: texto!)
        
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
        
        fraseTraduzidaLabel.attributedText = myMutableString
    }
    
}
