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
    
    override init() {
        
    }
    
    func traducaoTexto(text : String) {
        
        // Aonde colocamos a frase
        let separadorDasPalavras = NSCharacterSet(charactersInString: " ")
        var frase = text
        var fraseOrganizada : [String] = []
        fraseOrganizada = frase.componentsSeparatedByCharactersInSet(separadorDasPalavras)
        frase = (frase.lowercaseString)
        // Chama a API para classificar as frases.
        fraseClassificada = classifica.classify(frase)
        
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
            self.verboClassificado = verbo.tratarVerbo(fraseClassificada, tempo: 0)
            
            // Chama a classe que trata o complemento
            self.complementoClassificado = complemento.tratarComplemento(fraseClassificada, preposicao: verboClassificado[1])
            
            // Feito para juntar as palavras em uma String e colocar na tela.
            metodoJuntaPalavra(sujeitoClassificado)
            metodoJuntaPalavra(verboClassificado)
            metodoJuntaPalavra(complementoClassificado)
            
            frases.append(sujeitoClassificado)
            frases.append(verboClassificado)
            frases.append(complementoClassificado)
            
            /**********    COLOCA EM LETRA MAÍUSCULA   **********/
            
            juntaPalavras.replaceRange(juntaPalavras.startIndex...juntaPalavras.startIndex, with: String(juntaPalavras[juntaPalavras.startIndex]).capitalizedString)
            
            dicty.setValue(self.juntaPalavras, forKey: "Presente")
            
            //------------------> FRASE NO PASSADO <-------------------
            
            juntaPalavras.removeAll()
            
            // Chama a classe que trata o sujeito.
            self.sujeitoClassificado = sujeito.tratarSujeito(fraseClassificada)
            
            // Chama a classe que trata o Verbo.
            self.verboClassificado = verbo.tratarVerbo(fraseClassificada, tempo: 1)
            
            // Chama a classe que trata o complemento
            self.complementoClassificado = complemento.tratarComplemento(fraseClassificada, preposicao: verboClassificado[1])
            
            // Feito para juntar as palavras em uma String e colocar na tela.
            metodoJuntaPalavra(sujeitoClassificado)
            metodoJuntaPalavra(verboClassificado)
            metodoJuntaPalavra(complementoClassificado)
            
            frases.append(sujeitoClassificado)
            frases.append(verboClassificado)
            frases.append(complementoClassificado)
            
            /**********    COLOCA EM LETRA MAÍUSCULA   **********/
            
            juntaPalavras.replaceRange(juntaPalavras.startIndex...juntaPalavras.startIndex, with: String(juntaPalavras[juntaPalavras.startIndex]).capitalizedString)
            
            dicty.setValue(juntaPalavras, forKey: "Passado")
            
            //Retorna Dicionário
            self.translationDelegate?.traducaoSucesso(dicty, frases: frases)
        }
        else
        {
            dicty.setValue(text, forKey: "Presente")
            dicty.setValue(text, forKey: "Passado")
            
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
