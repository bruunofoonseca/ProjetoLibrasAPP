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
    
    // Variáveis
    let objSubstantivo = Substantivo()
    let objPronome = Pronome()
    var arrayArtigos : [String] = [""]
    var fraseClassificada : [Word] = []
    
    // Função para tratar o complemento de acordo com a frase.
    func tratarComplemento(frase : [Word], preposicao : String) -> [String]{
        if (frase[2].categories[0].text == "nome feminino") || (frase[2].categories[0].text == "nome masculino"){
            // irá colocar artigo caso não tenha preposição quando for substantivo.
            if (preposicao == "null"){
                arrayArtigos = objSubstantivo.classificaSubstantivo(frase, posicao: 2)
            }
        }
        else if (frase[2].categories[0].text == "pronome"){
            // irá colocar artigo caso não tenha preposição quando for pronome.
            if (preposicao == "null"){
                arrayArtigos = objPronome.categorizarPronome(frase, posicao: 2)
            }
        }
        arrayArtigos.append(frase[2].text + ".")
        return arrayArtigos
    }
}