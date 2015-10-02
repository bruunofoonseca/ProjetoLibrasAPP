//
//  SujeitoEstrutura.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 02/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class SujeitoEstrutura : NSObject {
    
    // Variaveis
    let artigo = Artigo()
    var arrayArtigos : [String] = []
    var fraseClassificada : [Word] = []

    // Função que irá tratar os sujeitos.
    func tratarSujeito(frase : [Word]) -> [String]{
        arrayArtigos = artigo.colocarArtigoDefinido(frase, posicao: 0)
        arrayArtigos.append(frase[0].text)
        return arrayArtigos
    }
}

