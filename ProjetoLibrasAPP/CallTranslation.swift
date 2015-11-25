//
//  CallTranslation.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno Pereira dos Santos on 11/11/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import UIKit

protocol CallTranslationDelegate {
    func traducaoSucesso(traducao : NSMutableDictionary, frases : [[String]])
}

class CallTranslation: NSObject {
    
    let classifica = Translator()
    var fraseClassificada : [Word] = []
    var dicty = NSMutableDictionary()
    
    var sujeitoClassificado : [String] = []
    let sujeito = SujeitoEstrutura()
    var complementoClassificado : [String] = []
    let complemento = ComplementoEstrutura()
    var verboClassificado: [String] = []
    let verbo = VerboEstrutura()
    var juntaPalavras : String = ""
    var translationDelegate: CallTranslationDelegate?
    var frases : [[String]] = []
    var organizaFrase : [Word] = []

    
    override init() {
        
    }
    
    func traducaoTexto(text : String) {
        
        frases = []
        
        // Aonde colocamos a frase
        let separadorDasPalavras = NSCharacterSet(charactersInString: " ")
        var frase = text
        var fraseOrganizada : [String] = []
        fraseOrganizada = frase.componentsSeparatedByCharactersInSet(separadorDasPalavras)
        frase = (frase.lowercaseString)
        self.juntaPalavras.removeAll()
        // Chama a API para classificar as frases.
        fraseClassificada = classifica.classify(frase)
        
        //var i = 0
        //var j = 0
        //var aux : Word
        
        //ORDENA AS PALAVRAS NA ORDEM DIGITADA
        
//        for orgWord in fraseOrganizada
//        {
//            for desorgWord in fraseClassificada
//            {
//                if orgWord == desorgWord.text
//                {
//                    aux = fraseClassificada[i]
//                    fraseClassificada[i] = fraseClassificada[j]
//                    fraseClassificada[j] = aux
//                }
//                j++
//            }
//            j = 0
//            i++
//        }
        
        organizaFrase.removeAll()
        
        for i in fraseOrganizada{
            for j in fraseClassificada{
                if i == j.text{
                    organizaFrase.append(j)
                }
            }
        }
        
//        let count = 3
        
//        while count < fraseClassificada.count
//        {
//            fraseClassificada.removeAtIndex(count)
//        }
        
        if organizaFrase.count == 3
        {
            if organizaFrase[2].text == "ontem"
            {
                //------------------> FRASE NO PASSADO <-------------------
                
                juntaPalavras.removeAll()
                
                // Chama a classe que trata o sujeito.
                self.sujeitoClassificado = sujeito.tratarSujeito(organizaFrase)
                print(sujeitoClassificado)
                
                // Chama a classe que trata o Verbo.
                self.verboClassificado = verbo.tratarVerbo(organizaFrase, tempo: 1)
                print(verboClassificado)
                
                // Chama a classe que trata o complemento
                self.complementoClassificado = complemento.tratarComplemento(organizaFrase, preposicao: verboClassificado[1])
                print(complementoClassificado)
                
                // Feito para juntar as palavras em uma String e colocar na tela.
                metodoJuntaPalavra(sujeitoClassificado)
                metodoJuntaPalavra(verboClassificado)
                metodoJuntaPalavra(complementoClassificado)
                
                /**********    COLOCA EM LETRA MAÍUSCULA   **********/
                
                juntaPalavras.replaceRange(juntaPalavras.startIndex...juntaPalavras.startIndex, with: String(juntaPalavras[juntaPalavras.startIndex]).capitalizedString)
                
                dicty.setValue(juntaPalavras, forKey: "Passado")
            }
            else
            {
                //------------------> FRASE NO PRESENTE <-------------------
                
                juntaPalavras.removeAll()
                
                // Chama a classe que trata o sujeito.
                self.sujeitoClassificado = sujeito.tratarSujeito(organizaFrase)
                
                // Chama a classe que trata o Verbo.
                self.verboClassificado = verbo.tratarVerbo(organizaFrase, tempo: 0)
                
                // Chama a classe que trata o complemento
                self.complementoClassificado = complemento.tratarComplemento(organizaFrase, preposicao: verboClassificado[1])
                
                // Feito para juntar as palavras em uma String e colocar na tela.
                metodoJuntaPalavra(sujeitoClassificado)
                metodoJuntaPalavra(verboClassificado)
                metodoJuntaPalavra(complementoClassificado)
                
                /**********    COLOCA EM LETRA MAÍUSCULA   **********/
                
                juntaPalavras.replaceRange(juntaPalavras.startIndex...juntaPalavras.startIndex, with: String(juntaPalavras[juntaPalavras.startIndex]).capitalizedString)
                
                dicty.setValue(self.juntaPalavras, forKey: "Presente")
                
                //------------------> FRASE NO PASSADO <-------------------
                
                juntaPalavras.removeAll()
                
                // Chama a classe que trata o sujeito.
                self.sujeitoClassificado = sujeito.tratarSujeito(organizaFrase)
                print(sujeitoClassificado)
                
                // Chama a classe que trata o Verbo.
                self.verboClassificado = verbo.tratarVerbo(organizaFrase, tempo: 1)
                print(verboClassificado)
                
                // Chama a classe que trata o complemento
                self.complementoClassificado = complemento.tratarComplemento(organizaFrase, preposicao: verboClassificado[1])
                print(complementoClassificado)
                
                // Feito para juntar as palavras em uma String e colocar na tela.
                metodoJuntaPalavra(sujeitoClassificado)
                metodoJuntaPalavra(verboClassificado)
                metodoJuntaPalavra(complementoClassificado)
                
                /**********    COLOCA EM LETRA MAÍUSCULA   **********/
                
                juntaPalavras.replaceRange(juntaPalavras.startIndex...juntaPalavras.startIndex, with: String(juntaPalavras[juntaPalavras.startIndex]).capitalizedString)
                
                dicty.setValue(juntaPalavras, forKey: "Passado")
                
                //------------------> FRASE NO FUTURO <-------------------
                
                juntaPalavras.removeAll()
                
                // Chama a classe que trata o sujeito.
                self.sujeitoClassificado = sujeito.tratarSujeito(organizaFrase)
                print(sujeitoClassificado)
                
                // Chama a classe que trata o Verbo.
                self.verboClassificado = verbo.tratarVerbo(organizaFrase, tempo: 2)
                print(verboClassificado)
                
                // Chama a classe que trata o complemento
                self.complementoClassificado = complemento.tratarComplemento(organizaFrase, preposicao: verboClassificado[1])
                print(complementoClassificado)
                
                // Feito para juntar as palavras em uma String e colocar na tela.
                metodoJuntaPalavra(sujeitoClassificado)
                metodoJuntaPalavra(verboClassificado)
                metodoJuntaPalavra(complementoClassificado)
                
                /**********    COLOCA EM LETRA MAÍUSCULA   **********/
                
                juntaPalavras.replaceRange(juntaPalavras.startIndex...juntaPalavras.startIndex, with: String(juntaPalavras[juntaPalavras.startIndex]).capitalizedString)
                
                dicty.setValue(juntaPalavras, forKey: "Futuro")
            }
            
            //Retorna Dicionário
            self.translationDelegate?.traducaoSucesso(dicty, frases: frases)
        }
        else
        {
            dicty.setValue(text, forKey: "Presente")
            dicty.setValue(text, forKey: "Passado")
            dicty.setValue(text, forKey: "Futuro")
            
            self.translationDelegate?.traducaoSucesso(dicty, frases: frases)
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
