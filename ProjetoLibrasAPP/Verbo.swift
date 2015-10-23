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
        var conjugVerbo = verbo.text
        
        for sujFlexion in sujeito.flexions
        {
            if sujFlexion.text == "sing" || sujFlexion.text == "Feminino singular" || sujFlexion.text == "Masculino singular"
            {
               conjugVerbo = api.get_verbs(verbo.text, flexion: "Presente - 3ª singular")
            }
            else if sujFlexion.text == "plur" || sujFlexion.text == "Feminino plural" || sujFlexion.text == "Masculino plural"
            {
               conjugVerbo = api.get_verbs(verbo.text, flexion: "Presente - 3ª plural") 
            }
        }
        
        return conjugVerbo
    }
}
