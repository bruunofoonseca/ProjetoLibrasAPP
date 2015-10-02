//
//  VerboEstrutura.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 02/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation

class VerboEstrutura : NSObject {
    
    let api = Translator()
    let objVerbo = Verbo()
    var defVerbo: [String] = []
    let prepo = Preposicao()
    var arrayPrepo : [String] = []
    
    func tratarVerbo(frase: [Word]) -> [String]
    {
        defVerbo.append(objVerbo.conjugVerboSujeito(frase[0], verbo: frase[1]))
        
        return defVerbo
    }
    
    func colocaPreposicao(texto : [Word]) -> [String]{
        arrayPrepo = prepo.Plistando(texto)
        return arrayPrepo
    }
}