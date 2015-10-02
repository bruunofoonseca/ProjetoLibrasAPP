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
    
    func verboConcordaSujeito(sujeito: Word, verbo: Word) -> String
    {
        let conjugVerbo = api.buscaVerbo(verbo.text, flexao: "Presente - 1ª singular", categoria: verbo.categories[0].text)
        
        return conjugVerbo
    }
}