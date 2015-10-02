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
    
    func tratarVerbo(frase: [Word]) -> String
    {
        let defVerbo = objVerbo.conjugVerboSujeito(frase[0], verbo: frase[1])
        
        return defVerbo
    }
}