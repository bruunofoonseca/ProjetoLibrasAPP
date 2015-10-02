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
    func colocarArtigoDefinido(frase : [Word]) -> [String] {
        
        //for para passar por cada palavra que existe na frase.
        for i in 0...frase.count - 1{
            //verifica se necessita do artigo na frase.
            if (frase[i].categories[0].text == "nome feminino"){
                if (i == 0){
                    artigos.append("A")
                }
                else{
                    artigos.append("a")
                }
            }
            else if (frase[i].categories[0].text == "nome masculino"){
                if (i == 0){
                    artigos.append("O")
                }
                else{
                    artigos.append("o")
                }
            }
            //caso nao seja necessário artigo ele preenche com espaço vazio.
            else{
                artigos.append("")
            }
        }
        //retorna array de strings com os artigos(caso tenha) referentes a cada palavra da frase.
        return artigos
    }
}
