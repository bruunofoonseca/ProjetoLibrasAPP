//
//  Artigo.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 01/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Artigo: NSObject {
    
    let metodo = Translator()
    var artigos : [String] = []

    override init(){
        super.init()
    }
    
    //método para colocar artigo definido na frase.
    func colocarArtigoDefinido(frase : [Word], posicao : Int) -> [String] {
        artigos.removeAll()
        if (frase[posicao].categories[0].text == "nome feminino") {
            if(frase[posicao].flexions[0].text == "singular") || (frase[posicao].flexions[0].text == "sing") || (frase[posicao].flexions[0].text == "Feminino singular"){
                if (posicao == 0){
                    artigos.append("A")
                }
                else{
                    artigos.append("a")
                }
            }
            else {
                if (posicao == 0){
                    artigos.append("As")
                }
                else{
                    artigos.append("as")
                }
            }
        }
        else if(frase[posicao].categories[0].text == "nome masculino"){
                if (frase[posicao].flexions[0].text == "singular") || (frase[posicao].flexions[0].text == "sing"){
                    if (posicao == 0){
                        artigos.append("O")
                    }
                    else{
                        artigos.append("o")
                    }
                }
                else if (frase[posicao].flexions[0].text == "plural") {
                    if (posicao == 0){
                        artigos.append("Os")
                    }
                    else{
                        artigos.append("os")
                    }
                }
        }
        else if (frase[posicao].categories[0].text == "pronome"){
            if (frase[posicao].text == "eu") || (frase[posicao].text == "você"){
                artigos.append("")
            }
        }
        else{
            artigos.append("")
        }
        
        //retorna array de strings com os artigos(caso tenha) referentes a cada palavra da frase.
        return artigos
    }
}
