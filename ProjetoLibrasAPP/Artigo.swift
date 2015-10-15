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
    
    /**********     MÉTODO QUE COLOCA ARTIGOS DEFINIDOS NA FRASE   **********/
    
    func colocarArtigoDefinido(frase : [Word], posicao : Int) -> [String] {
        artigos.removeAll()
        if (frase[posicao].categories[0].text == "nome feminino") {
            if(frase[posicao].flexions[0].text == "singular") || (frase[posicao].flexions[0].text == "sing") || (frase[posicao].flexions[0].text == "Feminino singular"){
                artigos.append("a")
            }
            else {
                artigos.append("as")
            }
        }
        else if(frase[posicao].categories[0].text == "nome masculino"){
                if (frase[posicao].flexions[0].text == "singular") || (frase[posicao].flexions[0].text == "sing"){
                    artigos.append("o")
                }
                else if (frase[posicao].flexions[0].text == "plural") {
                    artigos.append("os")
                }
        }
        else if (frase[posicao].categories[0].text == "pronome"){
            if(frase[posicao].flexions[0].text == "Masculino singular"){
                artigos.append("o")
            }
            else{
                artigos.append("")
            }
        }
        else{
            artigos.append("")
        }
        
        
    /**********     RETORNA ARTIGO CORRESPONDENTE   **********/
        return artigos
    }
}
