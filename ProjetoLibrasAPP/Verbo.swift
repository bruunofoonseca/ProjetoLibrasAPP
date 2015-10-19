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
    
    /**********     VARIÁVEIS    **********/
    
    let api = Translator()
    
    override init(){
        super.init()
    }
    
    /**********     FUNÇÃO QUE CONJUGA O VERBO    **********/

    func conjugVerboSujeito(sujeito: Word, verbo: Word) -> String
    {
        let conjugVerbo = api.get_verbs(verbo.text, flexion: "Infinitivo Flexionado - 1ª singular")
        
        return conjugVerbo
    }
}
