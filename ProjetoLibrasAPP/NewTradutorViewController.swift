//
//  NewTradutorViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 18/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class NewTradutorViewController: ViewController, UITextFieldDelegate, UIScrollViewDelegate, CallTranslationDelegate {

    @IBOutlet weak var sujeitoButton: UIButton!
    @IBOutlet weak var verboButton: UIButton!
    @IBOutlet weak var complementoButton: UIButton!
    @IBOutlet weak var guiaIndicador: UIView!
    @IBOutlet weak var guiaIndicadorLeading: NSLayoutConstraint!
    
    @IBOutlet weak var mainTextfield: UITextField!
    
    var frase = [String?](count: 3, repeatedValue: nil)
    var posicaoPrincipal = 0
    var currentPage:CGFloat = 0.0
    @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textoUsuario: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingImage: UIImageView!
    
    var frases : [[String]] = []
    var fraseTraduzida : [String] = []
    
    var callTranslation:CallTranslation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideBackButton()
        
        frase[0] = ""
        frase[1] = ""
        frase[2] = ""
        
        self.mainTextfield.delegate = self
        self.sujeitoButton.setTitleColor(UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), forState: UIControlState.Normal)
        self.guiaIndicador.backgroundColor = UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0)
        
        keyboardNotifications()
        initializeScroll()
        
        callTranslation = CallTranslation.init()
        callTranslation.translationDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        mainTextfield.becomeFirstResponder()
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        super.showMenu()
    }
    
    /* Traduz Palavra */
    
    func traduzFrase() {
        if (frase[0] != "" && frase[1] != "" && frase[2] != "") {
            self.startLoading()
            
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                
                let dispatchGroup = dispatch_group_create()
                
                dispatch_group_enter(dispatchGroup)
                self.callTranslation.traducaoTexto(self.textoUsuario.text!)
                dispatch_group_leave(dispatchGroup)
                
                
                dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), { () -> Void in
                    self.stopLoading()
                    self.performSegueWithIdentifier("ShowTraduzido", sender: nil)
                })
            }
        }
    }
    
    func traducaoSucesso(traducao : NSMutableDictionary, frases : [[String]]){
        self.frases = frases
        
        fraseTraduzida.append((traducao.objectForKey("Passado") as? String)!)
        fraseTraduzida.append((traducao.objectForKey("Presente") as? String)!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        mainTextfield.resignFirstResponder()
        
        if segue.identifier == "ShowTraduzido" {
            
            let svc = segue.destinationViewController as! TraduzidoViewController
            
            svc.fraseUsuario = textoUsuario.text!
            svc.fraseTraduzida = self.fraseTraduzida
        }
        
        textoUsuario.text = ""
    }
    
    /* Proxima Palavra */
    
    func avancaPalavra(){
        if mainTextfield.text == "" {
            avisoNenhumTexto()
        }else{
            limpaTextoNoFinal()
            colocaPalavraNaFrase()
            mostraFrase()
            modificaPlaceholder()
            mudaCorGuia()
            traduzFrase()
            mudaGuiaIndicador()
            moveToPage()
            mainTextfield.text = ""
            
            if posicaoPrincipal == 2 {
                posicaoPrincipal = 0
            }else{
                posicaoPrincipal++
            }
        }
    }
    
    func avisoNenhumTexto() {
        
        let alert = UIAlertView()
        alert.title = "Atenção"
        alert.message = "Não esqueça da palavra!"
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    func limpaTextoNoFinal() {
        if (frase[0] != "" && frase[1] != "" && frase[2] != "") {
            frase[0] = ""
            frase[1] = ""
            frase[2] = ""
            
            textoUsuario.text = ""
        }
    }
    
    func initializeScroll() {
        
        self.scrollView.frame = CGRect(x: 0,y: 0,width: self.view.frame.width, height: self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        let img1 = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        img1.image = UIImage(named: "Fundo2")
        
        let img2 = UIImageView(frame: CGRect(x: scrollViewWidth, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        img2.image = UIImage(named: "Fundo1")
        
        let img3 = UIImageView(frame: CGRect(x: scrollViewWidth * 2, y: 0, width: scrollViewWidth, height: scrollViewHeight))
        img3.image = UIImage(named: "VerdeS-1")
        
        self.scrollView.addSubview(img1)
        self.scrollView.addSubview(img2)
        self.scrollView.addSubview(img3)
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 3, self.scrollView.frame.height - 100)
        self.scrollView.delegate = self
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1
    }
    
    func moveToPage() {
        var posicao:Int
        if (posicaoPrincipal == 2){
            posicao = 0
        }else{
            posicao = posicaoPrincipal + 1
        }
        
        switch posicao {
        case 0:
            self.scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
            break
        case 1:
            self.scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
            break
        case 2:
            self.scrollView.scrollRectToVisible(CGRect(x: scrollView.frame.width * 2, y: 0, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
        default:
            break
        }
    }
    
    func mudaCorGuia(){
        var posicao:Int
        if (posicaoPrincipal == 2){
            posicao = 0
        }else{
            posicao = posicaoPrincipal + 1
        }
        
        switch(posicao){
            
        case 0:
            sujeitoButton.setTitleColor(UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), forState: UIControlState.Normal)
            verboButton.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
            complementoButton.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.guiaIndicador.backgroundColor = UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0)
            })
            break
        case 1:
            verboButton.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0), forState: UIControlState.Normal)
            sujeitoButton.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
            complementoButton.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.guiaIndicador.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.12, alpha:1.0)
            })
            break
        case 2:
            complementoButton.setTitleColor(UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0), forState: UIControlState.Normal)
            sujeitoButton.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
            verboButton.setTitleColor(UIColor(red:0.44, green:0.44, blue:0.47, alpha:1.0), forState: UIControlState.Normal)
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.guiaIndicador.backgroundColor = UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0)
            })
            break
        default:
            sujeitoButton.setTitleColor(UIColor(red:0.29, green:0.63, blue:0.07, alpha:1.0), forState: UIControlState.Normal)
            verboButton.setTitleColor(UIColor(red:0.38, green:0.05, blue:0.65, alpha:1.0), forState: UIControlState.Normal)
            complementoButton.setTitleColor(UIColor(red:0.05, green:0.25, blue:0.53, alpha:1.0), forState: UIControlState.Normal)
        }
    }
    
    func mudaGuiaIndicador() {
        var posicao:Int
        if (posicaoPrincipal == 2){
            posicao = 0
        }else{
            posicao = posicaoPrincipal + 1
        }
        
        let viewWidth:CGFloat = self.guiaIndicador.frame.width
        
        if posicao == 0 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.guiaIndicador.frame.origin.x = 0.0
                let const = self.guiaIndicador.frame.origin.x
                self.guiaIndicadorLeading.constant = const
                
            })
        }
        else if posicao == 1 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.guiaIndicador.frame.origin.x = viewWidth
                let const = self.guiaIndicador.frame.origin.x
                self.guiaIndicadorLeading.constant = const
                
            })
        }
        else if posicao == 2 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.guiaIndicador.frame.origin.x = viewWidth * 2
                let const = self.guiaIndicador.frame.origin.x
                self.guiaIndicadorLeading.constant = const
            })
        }
    }
    
    func colocaPalavraNaFrase(){
        frase[posicaoPrincipal] = mainTextfield.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func modificaPlaceholder() {
        var posicao:Int
        if (posicaoPrincipal == 2){
            posicao = 0
        }else{
            posicao = posicaoPrincipal + 1
        }
        
        switch posicao {
        case 0:
            mainTextfield.placeholder = "Digite o Sujeito"
            break
        case 1:
            mainTextfield.placeholder = "Digite o Verbo"
            break
        case 2:
            mainTextfield.placeholder = "Digite o Complemento"
        default:
            break
        }
    }
    
    func mostraFrase(){
        let texto = frase[0]! + " " + frase[1]! + " " + frase[2]!
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: texto)

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
        
        textoUsuario.attributedText = myMutableString
    }
    
    /* Eventos do espaço e do return */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        avancaPalavra()
        return true
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == " "){
            avancaPalavra()
            return false
        }
        else {
            return true
        }
    }
    
    /* Funções do KeyBoard */
    
    func keyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.textFieldBottomConstraint.constant = keyboardFrame.size.height
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        self.textFieldBottomConstraint.constant = self.textFieldBottomConstraint.constant - keyboardFrame.size.height
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        
    }
    
    /* Loading view */
    
    func startLoading(){
        mainTextfield.resignFirstResponder()
        
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
