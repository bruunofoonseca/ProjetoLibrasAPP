//
//  Preposicao.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 01/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Preposicao: NSObject {
    
    // Variáveis
    var palavra: [String] = []
    var colocaPreposicao : String = ""
    let path = NSBundle.mainBundle().pathForResource("Preposicao", ofType: "plist")
    var dict = NSDictionary!()
    
    override init(){
        super.init()
        dict = NSDictionary(contentsOfFile: path!)
    }
    
    // Verifica se o verbo tem preposição consultando a Plist Preposicao.
    func inserePreposicao(texto : [Word]) -> String {
        colocaPreposicao.removeAll()
        
        if (!verificaVerboNaLista(texto)){
            colocaPreposicao = ""
        }
        else {
            let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[0].text)?.valueForKey(texto[2].flexions[0].text) as AnyObject? as! String
            if (texto[1].text == "estar") || (texto[1].text == "poder") && (texto[2].text == "casa"){
                colocaPreposicao = "em"
            }
            else{
                colocaPreposicao = test
            }
        }
    
        return colocaPreposicao
    }
    
    // Verifica se a preposição está tratada. Caso esteja ele coloca preposição, caso não esteja ele não acrescenta.
    func verificaVerboNaLista(frase : [Word]) -> Bool {
        for (var i = 0; i <= (dict?.allKeys.count)! - 1 ; i++){
            if ((dict?.allKeys[i]) as! String == frase[1].text) {
                return true
            }
        }
        return false
    }
}