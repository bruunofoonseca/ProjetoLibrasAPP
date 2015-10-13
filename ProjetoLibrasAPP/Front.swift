//
//  Front.swift
//  ProjetoLibrasAPP
//
//  Created by André Rodrigues de Jesus on 10/7/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Front:UIViewController,UIScrollViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var frase: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var frameView: UIView!
    @IBOutlet weak var lblSujeito: UILabel!
    @IBOutlet weak var lblVerbo: UILabel!
    @IBOutlet weak var lblComplemento: UILabel!
    @IBOutlet weak var txtTexto: UITextField!
    @IBOutlet weak var txtTraducao: UILabel!
    var currentPage:CGFloat = 0.0
    var texto:String = ""
    // Variáveis
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTexto.becomeFirstResponder()
        txtTexto.returnKeyType = UIReturnKeyType.Next
    
        
        lblSujeito.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
        
        /**********     SCROLLVIEW      **********/
        
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        
        let viewSujeito = UIView(frame: CGRectMake(0, 0, scrollViewWidth, scrollViewHeight))
        let viewVerbo = UIView(frame: CGRectMake(scrollViewWidth, 0, scrollViewWidth, scrollViewHeight))
        let viewComplemento = UIView(frame: CGRectMake(scrollViewWidth*2, 0, scrollViewWidth, scrollViewHeight))
        
        self.scrollView.addSubview(viewSujeito)
        self.scrollView.addSubview(viewVerbo)
        self.scrollView.addSubview(viewComplemento)
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width*3, self.scrollView.frame.height)
        self.scrollView.delegate = self
        
        /**********     BOTÃO RETURN DO TECLADO     **********/
        
        self.txtTexto.delegate = self
                
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth:CGFloat = CGRectGetWidth(scrollView.frame)
        self.currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1
        print("Current page Scroll \(currentPage)")
        if Int(currentPage) == 0{

            lblSujeito.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
            lblVerbo.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            lblComplemento.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            txtTexto.placeholder = "Digite o Sujeito"
            
            
            
        }
        else if Int(currentPage) == 1{
            
            lblVerbo.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
            lblSujeito.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            lblComplemento.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            txtTexto.placeholder = "Digite o Verbo"
            
        }
        else if Int(currentPage) == 2{

            lblComplemento.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
            lblSujeito.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            lblVerbo.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            txtTexto.placeholder = "Digite o Complemento"
            
        }
    }
    
    func scrollToPage(page: Int,animated:Bool){
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page);
        frame.origin.y = 0;
        print(page)
        
        if page == 0 {
            lblSujeito.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
            lblVerbo.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            lblComplemento.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
        }
        else if page == 1 {
            
            lblVerbo.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
            lblSujeito.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            lblComplemento.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
        
        }
        else if page == 2 {

            lblComplemento.textColor = UIColor(red: (8/255), green: (191/255), blue: (134/255), alpha: 1)
            lblSujeito.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
            lblVerbo.textColor = UIColor(red: (111/255), green: (113/255), blue: (121/255), alpha: 1)
        }
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtTexto {
            print("Current page textField \(currentPage)")
            
            if self.currentPage == 0 {
                if temTexto{
                    frase.text.removeAll()
                    texto.removeAll()
                    juntaPalavras.removeAll()
                    txtTraducao.text?.removeAll()
                    temTexto = false
                }
                txtTraducao.text = ""
                frase.text! += " " + txtTexto.text!
                txtTexto.text = ""
                txtTexto.placeholder = "Digite o Sujeito"
                self.scrollToPage(1, animated: true)
                self.currentPage++
            }
            else if self.currentPage == 1 {
                frase.text! += " " + txtTexto.text!
                txtTexto.text = ""
                txtTexto.placeholder = "Digite o Verbo"
                self.scrollToPage(2, animated: true)
                self.currentPage++
            }
            else if self.currentPage == 2 {
                frase.text! += " " + txtTexto.text!
                txtTexto.text = ""
                txtTexto.placeholder = "Digite o Sujeito"
                txtTraducao.text = traducaoTexto(frase.text)
                self.scrollToPage(0, animated: true)
                temTexto = true
                self.currentPage = 0
            }
        }
        return true
    }
    
    func traducaoTexto(text : String) -> String {
        
        // Aonde colocamos a frase
        var frase = text
        print("Frase em Librês: " + frase)
        frase = (frase.lowercaseString)
        
        // Chama a API para classificar as frases.
        self.fraseClassificada = classifica.test_classify(frase)
        
        // Chama a classe que trata o sujeito.
        self.sujeitoClassificado = sujeito.tratarSujeito(fraseClassificada)
        
        // Chama a classe que trata o Verbo.
        self.verboClassificado = verbo.tratarVerbo(fraseClassificada)
        
        // Chama a classe que trata o complemento
        print(verboClassificado[0])
        print(verboClassificado[1])
        self.complementoClassificado = complemento.tratarComplemento(fraseClassificada, preposicao: verboClassificado[1])
        
        // Feito para juntar as palavras em uma String e colocar na tela.
        metodoJuntaPalavra(sujeitoClassificado)
        metodoJuntaPalavra(verboClassificado)
        metodoJuntaPalavra(complementoClassificado)
        
        return juntaPalavras
    }
    
    func metodoJuntaPalavra(texto : [String]){
        
        for i in 0...texto.count - 1 {
            if (texto[i] != "null" && texto[i] != ""){
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