
//  Front.swift
//  ProjetoLibrasAPP
//
//  Created by André Rodrigues de Jesus on 10/7/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TradutorViewController:UIViewController,UIScrollViewDelegate,UITextFieldDelegate,CallTranslationDelegate {
    
    /********** VARIÁVEIS DA INTERFACE  **********/
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtTexto: UITextField!
    @IBOutlet weak var lblTextoDigitado: UILabel!
    @IBOutlet weak var lblTraducao: UILabel!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBOutlet weak var btnSujeito: UIButton!
    @IBOutlet weak var btnVerbo: UIButton!
    @IBOutlet weak var btnComplemento: UIButton!
    @IBOutlet weak var viewIndicador: UIView!
    @IBOutlet weak var viewIndicadorLeading: NSLayoutConstraint!
    @IBOutlet weak var btnBarButtonVoltar: UIBarButtonItem!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingImage: UIImageView!
    
    var currentPage:CGFloat = 0.0
    var texto:String = ""
    
    var frase = [String?](count: 3, repeatedValue: nil)
    var atual = 0
    var atualPlaceHolder = 1
    var atualPage = 0
    
    /********** VARIÁVEIS DO ALGORITMO  **********/
    
    let classifica = Translator()
    var preposicao : [String] = []
    var verboAcesso = VerboEstrutura()
    var temTexto = false
    var atualiza = FraseViewController()
    var dicty = NSMutableDictionary()
    // Classe de conexão com o banco
    var callTranslation:CallTranslation!
    var palavrasSeparadas : [String] = []
    var frases : [[String]] = []
    
    /********** MÉTODO INICIAL  **********/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frase[0] = ""
        frase[1] = ""
        frase[2] = ""
        
        txtTexto.delegate = self
        txtTexto.returnKeyType = UIReturnKeyType.Next
        btnSujeito.setTitleColor(UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), forState: UIControlState.Normal)
        
        initializeScroll()
        initializeNotification()
        
        callTranslation = CallTranslation.init()
        callTranslation.translationDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        btnBarButtonVoltar.title = "Voltar"
        txtTexto.becomeFirstResponder()
        
        self.navigationItem.backBarButtonItem?.title = "voltar"
        self.navigationController?.navigationBarHidden = false
        lblTextoDigitado.text = ""
        lblTraducao.text = ""
        
    }
    
    /********** MÉTODOS DA INTERFACE  **********/
    
    func initializeNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    /* Função das segues */
    
    @IBAction func voltaTradutor(segue:UIStoryboardSegue){
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        txtTexto.resignFirstResponder()
        
        if segue.identifier == "traducao" {
            
            let svc = segue.destinationViewController as! TraducaoViewController

            svc.textoDigitado = lblTextoDigitado.text!
            svc.textoTraduzido = lblTraducao.text!
            svc.fraseList = frase
            svc.frases = self.frases
        }
        lblTextoDigitado.text = ""
    }
    
    func callNewSegue() {
        if atualPage == 0 {
            self.performSegueWithIdentifier("traducao", sender: nil)
        }
    }
    
    /* Função de Animação */
    
    func animation() {
        
        let chatLoader:UIImageView! = UIImageView(image: UIImage(named: "Sem título-2_00009"))
        
        chatLoader.animationImages = [UIImage]()
        
        for var index = 9; index < 69; index++ {
            let frameName = String(format: "Sem título-2_%05d", index)
            chatLoader.animationImages?.append(UIImage(named: frameName)!)
        }
        
        chatLoader.animationDuration = 1.5
        chatLoader.startAnimating()
    }
    
    /* Funções do Button */
    
    func itensColors(page:Int){
        
        switch(atualPage){
            
            case 0:
                btnSujeito.setTitleColor(UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), forState: UIControlState.Normal)
                btnVerbo.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                btnComplemento.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.viewIndicador.backgroundColor = UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0)
                })
                break
            case 1:
                btnVerbo.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0), forState: UIControlState.Normal)
                btnSujeito.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                btnComplemento.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.viewIndicador.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0)
                })
                break
            case 2:
                btnComplemento.setTitleColor(UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0), forState: UIControlState.Normal)
                btnSujeito.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                btnVerbo.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.viewIndicador.backgroundColor = UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0)
                })
                break
            default:
                btnSujeito.setTitleColor(UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0), forState: UIControlState.Normal)
                btnVerbo.setTitleColor(UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), forState: UIControlState.Normal)
                btnComplemento.setTitleColor(UIColor(red:0.05, green:0.25, blue:0.53, alpha:1.0), forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        
//        let identifyButton = sender.currentTitle!
//
//        switch identifyButton {
//            
//        case "Sujeito":
//            if txtTexto.text == "" {
//                alert()
//            }
//            else {
//                atualPage = 0
//                moveToPage(atualPage)
//                itensColors(atualPage)
//                textFieldPlaceHolder(atualPage)
//            }
//            
//            break
//        case "Verbo":
//            if txtTexto.text == "" {
//                alert()
//            }
//            else {
//                atualPage = 1
//                moveToPage(atualPage)
//                itensColors(atualPage)
//                textFieldPlaceHolder(atualPage)
//            }
//            break
//        case "Complemento":
//            if txtTexto.text == "" {
//                alert()
//            }
//            else {
//                atualPage = 2
//                moveToPage(atualPage)
//                itensColors(atualPage)
//                textFieldPlaceHolder(atualPage)
//            }
//            break
//        default:
//            print("Deu ruim painho!")
//            
//        }
        
    }
    
    /* Funções do Scroll */
    
    func initializeScroll() {
        
        self.scrollView.frame = CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        let img1 = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        img1.image = UIImage(named: "Fundo1")
        
        
        
        let img2 = UIImageView(frame: CGRect(x: scrollViewWidth, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        img2.image = UIImage(named: "Fundo2")
        
        let img3 = UIImageView(frame: CGRect(x: scrollViewWidth * 2, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        img3.image = UIImage(named: "Fundo3")
        
        self.scrollView.addSubview(img1)
        self.scrollView.addSubview(img2)
        self.scrollView.addSubview(img3)
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 3, self.scrollView.frame.height - 100)
        self.scrollView.delegate = self
        
    }
    
    func moveToPage(page: Int) {
        
        switch page {
        case 0:
            self.scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
            break
        case 1:
            self.scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
            break
        case 2:
            self.scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.width * 2, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
        default:
            print("sei la")
        }
    }
    
    func mudaAnimacao() {
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        
        //print("currentPage in mudaAnimacao \(currentPage)")
        
        if currentPage == 0.0 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.viewIndicador.frame.origin.x = 0.0
                let const = self.viewIndicador.frame.origin.x
                self.viewIndicadorLeading.constant = const
                
            })
        }
        else if currentPage == 1.0 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.viewIndicador.frame.origin.x = scrollViewWidth / 3
                let const = self.viewIndicador.frame.origin.x
                self.viewIndicadorLeading.constant = const
                
            })
        }
        else if currentPage == 2.0 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.viewIndicador.frame.origin.x = (2*scrollViewWidth) / 3
                let const = self.viewIndicador.frame.origin.x
                self.viewIndicadorLeading.constant = const
            })
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1
        
        //print("currentPage in scrollViewDidScroll \(currentPage)")
        
        mudaAnimacao()
    }
    
    /* Funções do KeyBoard */
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.constraint.constant = keyboardFrame.size.height
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.constraint.constant = self.constraint.constant - keyboardFrame.size.height
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        
    }
    
    /* Funções do TextField */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //print("AtualPage antes do if \(atualPage)")
        if atualPage == 2 {
            atualPage = -1
        }
        atualPage++
        limpaTudo()
        colocaNaFrase(atualPage)
        mostraNaTela()
        moveToPage(atualPage)
        textFieldPlaceHolder(atualPage)
        itensColors(atualPage)
        exibeTraducao()
        txtTexto.text = ""
        
        return true
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if atualPage == 2 {
            atualPage = -1
        }
        
        if (string == " "){
            if txtTexto.text == "" {
                
                alert()
                return false
            }
            else {
                atualPage++
                limpaTudo()
                colocaNaFrase(atualPage)
                mostraNaTela()
                moveToPage(atualPage)
                textFieldPlaceHolder(atualPlaceHolder)
                itensColors(atualPage)
                exibeTraducao()
                txtTexto.text = ""
                
                return false
            }
        }
        else {
            
            return true
        }
    }
    
    func textFieldPlaceHolder(item:Int) {
        //print("textFieldPlaceHolder \(item)")
        switch item {
        case 0:
            txtTexto.placeholder = "Digite o Sujeito"
            break
        case 1:
            txtTexto.placeholder = "Digite o Verbo"
            break
        case 2:
            txtTexto.placeholder = "Digite o Complemento"
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
    
    func colocaNaFrase(atualIndex:Int){
        
        var index = atualIndex - 1
        
        if index == -1 {
            index = 2
        }
        
        switch index {
        case 0:
            frase[index] = txtTexto.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            break
        case 1:
            frase[index] = txtTexto.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            break
        case 2:
            frase[index] = txtTexto.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            break
        default:
            print("Deu erro")
        }
//        print(index)
//        print(frase[0])
//        print(frase[1])
//        print(frase[2])
        
    }
    
    func mostraNaTela(){
        let texto = frase[0]! + " " + frase[1]! + " " + frase[2]!
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: texto)
        
        print("tamanho: " + String(texto.characters.count))
        
        var initial = 0
        var final = 0
        
        if (frase[0]?.characters.count != 0){
            initial = 0
            final = (frase[0]?.characters.count)!
            
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), range:NSRange(location:initial, length:final))
        }
        
        if (frase[1]?.characters.count != 0){
            initial = (frase[0]?.characters.count)! + 1
            final = (frase[1]?.characters.count)!
            
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0), range:NSRange(location:initial, length:final))
        }
        
        if (frase[2]?.characters.count != 0){
            initial = (frase[0]?.characters.count)! + (frase[1]?.characters.count)! + 2
            final = (frase[2]?.characters.count)!
            
            myMutableString.addAttribute(NSForegroundColorAttributeName, value:UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0), range:NSRange(location:initial, length:final))
        }
        
        lblTextoDigitado.attributedText = myMutableString
    }

    func exibeTraducao() {
        if (frase[0] != "" && frase[1] != "" && frase[2] != "") {
            
            self.startLoading()
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                
                let dispatchGroup = dispatch_group_create()
                
                dispatch_group_enter(dispatchGroup)
                self.callTranslation.traducaoTexto(self.lblTextoDigitado.text!)
                dispatch_group_leave(dispatchGroup)
                
                
                dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), { () -> Void in
                    self.stopLoading()
                    self.callNewSegue()
                })
            }
            
        }
    }
    
    func limpaTudo() {
        if (frase[0] != "" && frase[1] != "" && frase[2] != "") {
            frase[0] = ""
            frase[1] = ""
            frase[2] = ""
            
            lblTraducao.text = ""
        }
//        print("LimpaTudo \(frase[0])")
//        print(frase[1])
//        print(frase[2])
    }
    
    func traducaoSucesso(traducao : NSMutableDictionary, frases : [[String]]){
        self.frases = frases
        
        let index = 1
        
        if index == 0
        {
            lblTraducao.text = traducao.objectForKey("Presente") as? String
        }
        else{
            lblTraducao.text = traducao.objectForKey("Passado") as? String
        }
        
        
    }
    
    func startLoading(){
        txtTexto.resignFirstResponder()
        
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        loadingView.superview!.bringSubviewToFront(loadingView)
        
        loadingImage.animationImages = [UIImage]()
        
        for var index = 9; index < 69; index++ {
            let frameName = String(format: "Sem título-2_%05d", index)
            loadingImage.animationImages?.append(UIImage(named: frameName)!)
        }
        
        loadingImage.animationDuration = 1.5
        loadingImage.startAnimating()
    }
    
    func stopLoading(){
        loadingView.superview!.sendSubviewToBack(loadingView)
        loadingImage.stopAnimating()
    }
}