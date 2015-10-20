//
//  VerboEstrutura.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 02/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation

class VerboEstrutura : NSObject {
    
    /**********     VARIÁVEIS   **********/

    let api = Translator()
    let objVerbo = Verbo()
    var defVerbo: [String] = []
    let objPreposicao = Preposicao()
    
    
    /**********     FUNÇÃO QUE TRATA O VERBO DE ACORDO COM O SUJEITO E INSERE PREPOSIÇÃO   **********/

    func tratarVerbo(frase: [Word]) -> [String]
    {
        defVerbo.removeAll()
        
        if (frase[1].categories[0].text == "verbo"){
            defVerbo.append(objVerbo.conjugVerboSujeito(frase[0], verbo: frase[1]))
        }
        else{
            defVerbo.append(frase[1].text)
        }
        defVerbo.append(objPreposicao.inserePreposicao(frase))
        
        return defVerbo
    }
}