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
    
    let api = Translator()
    
    override init(){
        super.init()
    }
    
    func conjugVerboSujeito(sujeito: Word, verbo: Word) -> String
    {
        let conjugVerbo = api.buscaVerbo(verbo.text, flexao: sujeito.flexions[1].text, categoria: verbo.text)
        
        return conjugVerbo
    }
}
