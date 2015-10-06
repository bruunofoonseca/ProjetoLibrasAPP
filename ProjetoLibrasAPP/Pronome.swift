//
//  Pronome.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 01/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Pronome: NSObject {
    
    // Variáveis
    var recebeArtigo : [String] = []
    var objArtigo = Artigo()
    
    override init(){
        super.init()
    }
    
    // Trata o pronome de acordo com a sua particularidade (Pronome pessoal, pronome de tratamento).
    func categorizarPronome(frase : [Word], posicao : Int) -> [String]{
        if (frase[posicao].categories[0].text == "pronome"){
            if (frase[posicao].text == "eu") || (frase[posicao].text == "tu") || (frase[posicao].text == "ele") || (frase[posicao].text == "nós") || (frase[posicao].text == "vós") || (frase[posicao].text == "eles") || (frase[posicao].text == "ela") || (frase[posicao].text == "elas"){
                recebeArtigo = objArtigo.colocarArtigoDefinido(frase, posicao: posicao)
            }
            else if (frase[posicao].text == "senhor" || frase[posicao].text == "senhora" || frase[posicao].text == "senhorita")
            {
                recebeArtigo = objArtigo.colocarArtigoDefinido(frase, posicao: posicao)
            }
            else
            {
                recebeArtigo.append("")
            }
        }
        
        return recebeArtigo
    }
    
}