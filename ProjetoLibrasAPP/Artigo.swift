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
    
    //let metodo = Translator()
    var artigos : [String] = []

    override init(){
        super.init()
    }
    
    /**********     MÉTODO QUE COLOCA ARTIGOS DEFINIDOS NA FRASE   **********/
    
    func colocarArtigoDefinido(frase : [Word], posicao : Int, posCategoria : Int, posFlexion : Int) -> [String] {
        
        artigos.removeAll()
    
        if (frase[posicao].categories[posCategoria].text == "nome feminino") {
            if(frase[posicao].flexions[posFlexion].text == "singular") || (frase[posicao].flexions[posFlexion].text == "sing") || (frase[posicao].flexions[posFlexion].text == "Feminino singular") || (frase[posicao].flexions[posFlexion].text == "Masculino singular"){
                artigos.append("a")
            }
            else {
                artigos.append("as")
            }
        }
        else if(frase[posicao].categories[posCategoria].text == "nome masculino") {
            if (frase[posicao].flexions[posFlexion].text == "singular") || (frase[posicao].flexions[posFlexion].text == "sing") || (frase[posicao].flexions[posFlexion].text == "Masculino singular") || (frase[posicao].flexions[posFlexion].text == "Feminino singular"){
                artigos.append("o")
            }
            else {
                artigos.append("os")
            }
        }
        else if (frase[posicao].categories[posCategoria].text == "pronome"){
            if(frase[posicao].flexions[posFlexion].text == "Masculino singular"){
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
