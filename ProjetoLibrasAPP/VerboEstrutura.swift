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
    let objPreposicao = Preposicao()
    
    // funcao que trata o verbo de acordo com o sujeito e coloca preposição.
    func tratarVerbo(frase: [Word]) -> [String]
    {
        defVerbo.removeAll()
        defVerbo.append(objVerbo.conjugVerboSujeito(frase[0], verbo: frase[1]))
        defVerbo.append(objPreposicao.Plistando(frase))
        
        return defVerbo
    }
}