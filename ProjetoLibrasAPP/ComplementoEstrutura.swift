//
//  ComplementoEstrutura.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 02/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class ComplementoEstrutura : NSObject {
    
    let artigo = Artigo()
    var arrayArtigos : [String] = [""]
    var fraseClassificada : [Word] = []
    var prepo = Preposicao()
    
    func tratarComplemento(frase : [Word], preposicao : String) -> [String]{
        if (preposicao == "null"){
            arrayArtigos = artigo.colocarArtigoDefinido(frase, posicao: 2)
        }
        arrayArtigos.append(frase[2].text + ".")
        return arrayArtigos
    }
}