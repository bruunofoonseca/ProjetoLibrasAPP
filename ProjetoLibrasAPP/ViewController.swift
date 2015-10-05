//
//  ViewController.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 30/09/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Aonde colocamos a frase
        let frase = "senhor ir casas"
        
        // Chama a API para classificar as frases.
        self.fraseClassificada = classifica.test_classify(frase)
        
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
        
        // Exibe a frase na tela.
        print(juntaPalavras)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

