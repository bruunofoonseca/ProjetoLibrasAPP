//
//  ViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 30/09/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let classifica = Translator()
    let artigo = Artigo()
    var fraseClassificada : [Word] = []
    var arrayArtigos : [String] = []
    var novaFrase: [String] = []
    var juntaPalavras : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Aonde colocamos a frase
        let frase = "bolo bola"
        
        //chama os metodos de classificar e colocar artigos.
        self.fraseClassificada = classifica.test_classify(frase)
        self.arrayArtigos = artigo.colocaArtigoDefinido(fraseClassificada)
        
        //feito para juntar as palavras em uma String e colocar na tela.
        metodoJuntaPalavra()
    }
    
    func metodoJuntaPalavra(){
        for i in 0...self.fraseClassificada.count - 1{
            if arrayArtigos[i] != ""{
                juntaPalavras += arrayArtigos[i] + " "
            }
            juntaPalavras += fraseClassificada[i].text + " "
        }
        
        print(juntaPalavras)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

