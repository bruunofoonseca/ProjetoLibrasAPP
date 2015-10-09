//
//  Substantivo.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 01/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Substantivo: NSObject {
    
    // Variáveis
    var recebeArtigo : [String] = []
    var objArtigo = Artigo()
    
    override init(){
        super.init()
    }
    
    func classificaSubstantivo(frase: [Word], posicao : Int) -> [String]{
        recebeArtigo.removeAll()
        if (frase[0].categories[0].text == "nome feminino") || (frase[0].categories[0].text == "nome masculino"){
            recebeArtigo = objArtigo.colocarArtigoDefinido(frase, posicao: posicao)
        }
        
        return recebeArtigo
    }
}