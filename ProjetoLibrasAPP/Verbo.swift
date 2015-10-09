//
//  Verbo.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 01/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Verbo: NSObject {
    
    // Variáveis
    let api = Translator()
    
    override init(){
        super.init()
    }
    
    // Conjuga o verbo
    func conjugVerboSujeito(sujeito: Word, verbo: Word) -> String
    {
        let conjugVerbo = api.buscaVerbo(verbo.text, sujeito: sujeito.text,flexao: sujeito.flexions[0].text, categoria: verbo.text)
        
        return conjugVerbo
    }
}
