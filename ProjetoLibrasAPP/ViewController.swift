//
//  ViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 30/09/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let metodo = Translator()
    let artigo = Artigo()
    var ab : [Word] = []
    var ac : [String] = []
    var novaFrase: [String] = []
    var juntaPalavras : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Aonde colocamos a frase
        let frase = "bolo bola"
        
        //chama os metodos de classificar e colocar artigos.
        self.ab = metodo.test_classify(frase)
        self.ac = artigo.colocaArtigoDefinido(ab)
        
        //feito para juntar as palavras em uma String e colocar na tela.
        metodoJuntaPalavra()
    }
    
    func metodoJuntaPalavra(){
        for i in 0...self.ab.count - 1{
            if ac[i] != ""{
                juntaPalavras += ac[i] + " "
            }
            juntaPalavras += ab[i].text + " "
        }
        
        print(juntaPalavras)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

