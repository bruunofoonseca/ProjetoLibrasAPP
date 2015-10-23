
//  Front.swift
//  ProjetoLibrasAPP
//
//  Created by André Rodrigues de Jesus on 10/7/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Front:UIViewController,UIScrollViewDelegate,UITextFieldDelegate {
    
    /********** VARIÁVEIS DA INTERFACE  **********/
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var frameView: UIView!
    
    @IBOutlet weak var txtTexto: UITextField!
    
    @IBOutlet weak var lblTextoDigitado: UILabel!
    @IBOutlet weak var lblTraducao: UILabel!
    
    @IBOutlet weak var constraint: NSLayoutConstraint!
    var currentPage:CGFloat = 0.0
    var texto:String = ""
    
    @IBOutlet weak var btnSujeito: UIButton!
    @IBOutlet weak var btnVerbo: UIButton!
    @IBOutlet weak var btnComplemento: UIButton!
    
    var frase = [String?](count: 3, repeatedValue: nil)
    var atual = 0
    var atualButton = 0
    var atualScrollView = 0
    var atualPlaceHolder = 1
    
    /********** VARIÁVEIS DO ALGORITMO  **********/
    
    let classifica = Translator()
    var sujeitoClassificado : [String] = []
    let sujeito = SujeitoEstrutura()
    var complementoClassificado : [String] = []
    let complemento = ComplementoEstrutura()
    var verboClassificado: [String] = []
    let verbo = VerboEstrutura()
    var preposicao : [String] = []
    var fraseClassificada : [Word] = []
    var juntaPalavras : String = ""
    var verboAcesso = VerboEstrutura()
    var temTexto = false
    var atualiza = FraseViewController()
    
    /********** MÉTODO INICIAL  **********/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frase[0] = ""
        frase[1] = ""
        frase[2] = ""
        
        txtTexto.delegate = self
        
        txtTexto.becomeFirstResponder()
        txtTexto.returnKeyType = UIReturnKeyType.Next
        
//        initializeButtonTitleColors()
        initializeScroll()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        
    }
    
    /********** MÉTODOS DA INTERFACE  **********/
    
    /* Função da segue(Voltar da View Frases para View Tradutor) */
    
    @IBAction func voltaTradutor(segue:UIStoryboardSegue){
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        txtTexto.resignFirstResponder()
    }
    
    /* Funções do Button */
    
    func initializeButtonTitleColors(){
        
        switch(atualButton){
            
            case 0:
                btnSujeito.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0), forState: UIControlState.Normal)
                btnVerbo.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                btnComplemento.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                break
            case 1:
                btnVerbo.setTitleColor(UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), forState: UIControlState.Normal)
                btnSujeito.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                btnComplemento.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                break
            case 2:
                btnComplemento.setTitleColor(UIColor(red:0.05, green:0.25, blue:0.53, alpha:1.0), forState: UIControlState.Normal)
                btnSujeito.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                btnVerbo.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                break
            default:
                btnSujeito.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0), forState: UIControlState.Normal)
                btnVerbo.setTitleColor(UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), forState: UIControlState.Normal)
                btnComplemento.setTitleColor(UIColor(red:0.05, green:0.25, blue:0.53, alpha:1.0), forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func btnSujeitoPressed(sender: AnyObject) {
//        if (btnSujeito.enabled == true && atualButton == 0)  {
//            colocaNaFrase()
//            avancaTitulo()
//            //marcaTitulo()
//            mostraNaTela()
//            txtTexto.text = ""
//            moveToNextPage()
//            atualButton++
//            initializeButtonTitleColors()
//            print("atualButton \(atualButton)")
//            print("atual \(atual)")
//        }
    }
    @IBAction func btnVerboPressed(sender: AnyObject) {
//        if (btnVerbo.enabled == true && atualButton == 1) {
//            colocaNaFrase()
//            avancaTitulo()
//            //marcaTitulo()
//            mostraNaTela()
//            txtTexto.text = ""
//            moveToNextPage()
//            atualButton++
//            initializeButtonTitleColors(atualButton)
//            print("atualButton \(atualButton)")
//            print("atual \(atual)")
//        }
    }
    @IBAction func btnComplementoPressed(sender: AnyObject) {
//        if (btnComplemento.enabled == true && atualButton == 2) {
//            colocaNaFrase()
//            avancaTitulo()
//            //marcaTitulo()
//            mostraNaTela()
//            txtTexto.text = ""
//            moveToNextPage()
//            atualButton = 0
//            initializeButtonTitleColors(atualButton)
//            print("atualButton \(atualButton)")
//            print("atual \(atual)")
//        }
    }
    
    /* Funções do Scroll */
    
    func initializeScroll() {
        
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        let viewSujeito = UIImageView(frame: CGRectMake(0, 0, scrollViewWidth, scrollViewHeight))
        viewSujeito.image = UIImage(named: "Fundo1")
        
        let viewVerbo = UIImageView(frame: CGRectMake(scrollViewWidth, 0, scrollViewWidth, scrollViewHeight))
        viewVerbo.image = UIImage(named: "Fundo2")
        
        let viewComplemento = UIImageView(frame: CGRectMake(scrollViewWidth*2, 0, scrollViewWidth, scrollViewHeight))
        viewComplemento.image = UIImage(named: "Fundo3")
        
        self.scrollView.addSubview(viewSujeito)
        self.scrollView.addSubview(viewVerbo)
        self.scrollView.addSubview(viewComplemento)
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width*3, self.scrollView.frame.height-100)
        print(self.scrollView.frame.height)
        self.scrollView.delegate = self
    }
    
    func moveToNextPage() {
        
        // Move to next page
        let pageWidth:CGFloat = CGRectGetWidth(self.scrollView.frame)
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if (contentOffset + pageWidth == maxWidth){
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRectMake(slideToX, 0, pageWidth, CGRectGetHeight(self.scrollView.frame)), animated: true)
    }
    
    
    /* Funções do TextField */
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.constraint.constant = keyboardFrame.size.height
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.constraint.constant = self.constraint.constant - keyboardFrame.size.height
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
       txtTexto.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if txtTexto.text == "" {
            print(txtTexto.text)
            alert()
            
            return false
        }
        else {
            colocaNaFrase()
            avancaTitulo()
            //marcaTitulo()
            mostraNaTela()
            textFieldPlaceHolder(atualPlaceHolder)
            txtTexto.text = ""
            moveToNextPage()
            
            return true
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (string == " "){
            if txtTexto.text == "" {
                
                alert()
                return false
            }
            else {
                
                colocaNaFrase()
                avancaTitulo()
                //marcaTitulo()
                mostraNaTela()
                textFieldPlaceHolder(atualPlaceHolder)
                txtTexto.text = ""
                moveToNextPage()
                
                return true
            }
        }
        else {
            
            return true
        }
    }
    
    func textFieldPlaceHolder(item:Int) {
        print(item)
        switch item {
        case 0:
            txtTexto.placeholder = btnSujeito.titleLabel?.text
            atualPlaceHolder++
            break
        case 1:
            txtTexto.placeholder = btnVerbo.titleLabel?.text
            atualPlaceHolder++
            break
        case 2:
            txtTexto.placeholder = btnComplemento.titleLabel?.text
            atualPlaceHolder = 0
        default:
            txtTexto.placeholder = "Digite a palavra"
        }
        
        
    }
    
    /* Função de alert */
    
    func alert() {
        
        let alert = UIAlertView()
        alert.title = "Atenção"
        alert.message = "Não esqueça da palavra!"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    /* Funções de Texto */
    
    func colocaNaFrase(){
        frase[atual] = txtTexto.text!
    }
    
    func mostraNaTela(){
        let texto = frase[0]! + " " + frase[1]! + " " + frase[2]!
        
        lblTextoDigitado.text = texto
    }
    
    func avancaTitulo(){
        if atual == 2{
            
            atual = 0
            mostraNaTela()
            lblTraducao.text = traducaoTexto(lblTextoDigitado.text!)
            
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let contexto: NSManagedObjectContext = appDel.managedObjectContext
            
            let novaFrase = NSEntityDescription.insertNewObjectForEntityForName("Frase", inManagedObjectContext:contexto)
            novaFrase.setValue(lblTraducao.text, forKey: "salvaFrase")
            
            
            do{
                try contexto.save()
            }catch{
                print("Erro ao salvar")
            }
            atualiza.atualizarTotalDasFrases()
            
            
        }else if atual == 0{
            
            if lblTextoDigitado.text != ""{
                
                //frase[0] = ""
                frase[1] = ""
                frase[2] = ""
                
                lblTraducao.text = ""
            }
            
            atual += 1
        }else{
            atual += 1
        }
    }
    
    
    
//    func marcaTitulo(){
//        
//        if (self.atual == 0){
//            btnSujeito.titleLabel?.text = btnSujeito.titleLabel?.text
//            
//            self.btnSujeito.ti = self.sublinha(self.btnSujeito.attributedText as! NSMutableAttributedString)
//            btnVerbo.titleLabel?.text = btnVerbo.titleLabel?.text
//            self.verbo.attributedText = self.desSublinha(self.verbo.attributedText as! NSMutableAttributedString)
//            btnComplemento.titleLabel?.text = btnComplemento.titleLabel?.text
//            self.complemento.attributedText = self.desSublinha(self.complemento.attributedText as! NSMutableAttributedString)
//        }else if (self.atual == 1){
//            btnVerbo.titleLabel?.text = btnVerbo.titleLabel?.text
//            
//            self.verbo.attributedText = self.sublinha(self.verbo.attributedText as! NSMutableAttributedString)
//            btnSujeito.titleLabel?.text = btnSujeito.titleLabel?.text
//            self.sujeito.attributedText = self.desSublinha(self.sujeito.attributedText as! NSMutableAttributedString)
//            btnComplemento.titleLabel?.text = btnComplemento.titleLabel?.text
//            self.complemento.attributedText = self.desSublinha(self.complemento.attributedText as! NSMutableAttributedString)
//        }else if (self.atual == 2){
//            btnComplemento.titleLabel?.text = btnComplemento.titleLabel?.text
//            
//            btnSujeito.titleLabel?.text = btnSujeito.titleLabel?.text
//            self.sujeito.attributedText = self.desSublinha(self.sujeito.attributedText as! NSMutableAttributedString)
//            btnVerbo.titleLabel?.text = btnVerbo.titleLabel?.text
//            self.verbo.attributedText = self.desSublinha(self.verbo.attributedText as! NSMutableAttributedString)
//            btnComplemento.titleLabel?.text = btnComplemento.titleLabel?.text
//            self.complemento.attributedText = self.sublinha(self.complemento.attributedText as! NSMutableAttributedString)
//        }
//    }
    
    func sublinha(string:NSMutableAttributedString) -> NSMutableAttributedString{
        string.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSRange(location:0,length:string.length))
        
        return string
    }
    
    func desSublinha(string:NSMutableAttributedString) -> NSMutableAttributedString{
        string.addAttribute(NSUnderlineStyleAttributeName, value: 0, range: NSRange(location:0,length:string.length))
        
        return string
    }
    
    /********** MÉTODOS DE CONEXÃO ENTRE ALGORITMO  E INTERFACE  **********/
    
    func traducaoTexto(text : String) -> String {
        
        // Aonde colocamos a frase
        let separadorDasPalavras = NSCharacterSet(charactersInString: " ")
        var frase = text
        var fraseOrganizada : [String] = []
        fraseOrganizada = frase.componentsSeparatedByCharactersInSet(separadorDasPalavras)
        print("Frase em Librês: " + frase)
        frase = (frase.lowercaseString)
        juntaPalavras.removeAll()
        // Chama a API para classificar as frases.
        self.fraseClassificada = classifica.classify(frase)
        
        var i = 0
        var aux : Word

        //ORDENA AS PALAVRAS NA ORDEM DIGITADA
        
        while(i != fraseClassificada.count){
            for(var j = 0; j < fraseClassificada.count; j++){
                if(fraseClassificada[j].text == fraseOrganizada[i]){
                    aux = fraseClassificada[i]
                    fraseClassificada[i] = fraseClassificada[j]
                    fraseClassificada[j] = aux
                }
            }
            i++
        }
        
        if self.fraseClassificada.count == 3
        {
            // Chama a classe que trata o sujeito.
            self.sujeitoClassificado = sujeito.tratarSujeito(fraseClassificada)
            
            // Chama a classe que trata o Verbo.
            self.verboClassificado = verbo.tratarVerbo(fraseClassificada)
            
            // Chama a classe que trata o complemento
            self.complementoClassificado = complemento.tratarComplemento(fraseClassificada, preposicao: verboClassificado[1])
            
            // Feito para juntar as palavras em uma String e colocar na tela.
            metodoJuntaPalavra(sujeitoClassificado)
            metodoJuntaPalavra(verboClassificado)
            metodoJuntaPalavra(complementoClassificado)
            
            /**********    COLOCA EM LETRA MAÍUSCULA   **********/
            
            juntaPalavras.replaceRange(juntaPalavras.startIndex...juntaPalavras.startIndex, with: String(juntaPalavras[juntaPalavras.startIndex]).capitalizedString)
            
            return juntaPalavras
        }
        else
        {
            return text
        }
    }
    
    func metodoJuntaPalavra(texto : [String]){
        
        for i in 0...texto.count - 1 {
            if (texto[i] != "null" && texto[i] != "" && texto[i] != " "){
                if (texto[i] != "."){
                    juntaPalavras += texto[i] + " "
                }
                else{
                    juntaPalavras += texto[i]
                }
            }
        }
    }
}