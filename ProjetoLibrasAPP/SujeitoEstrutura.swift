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
    let objSubstantivo = Substantivo()
    let objPronome = Pronome()
    var arrayArtigos : [String] = []
    var arrayPronome : [String] = []
    var fraseClassificada : [Word] = []

    // Função que irá tratar os sujeitos.
    func tratarSujeito(frase : [Word]) -> [String]{
        arrayArtigos.removeAll()
        if (frase[0].categories[0].text == "nome feminino") || (frase[0].categories[0].text == "nome masculino") {
            arrayArtigos = objSubstantivo.classificaSubstantivo(frase, posicao: 0)
        }
        else if (frase[0].categories[0].text == "pronome"){
            arrayArtigos = objPronome.categorizarPronome(frase, posicao: 0)
        }
        arrayArtigos.append(frase[0].text)
        return arrayArtigos
    }
}

