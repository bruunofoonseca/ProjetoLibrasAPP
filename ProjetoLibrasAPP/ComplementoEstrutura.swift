//
//  ComplementoEstrutura.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 02/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class ComplementoEstrutura : NSObject {
    
    /**********     VARIÁVEIS   **********/
    
    let objSubstantivo = Substantivo()
    let objPronome = Pronome()
    let translator = Translator()
    var arrayArtigos : [String] = [""]
    var pronomeTonico : [String] = []
    var fraseClassificada : [Word] = []
    
    /**********     FUNÇÃO QUE TRATA O COMPLEMENTO DE ACORDO COM A FRASE   **********/
    
    func tratarComplemento(frase : [Word], preposicao : String) -> [String]{
        arrayArtigos.removeAll()
        print(frase[2].categories[0].text)
        if (frase[2].categories[0].text == "nome feminino") || (frase[2].categories[0].text == "nome masculino"){
            
     /**********     IRÁ COLOCAR ARTIGO CASO NÃO TENHA PREPOSIÇÃO QUANDO FOR SUBSTANTIVO   **********/

            if (preposicao == "null"){
                arrayArtigos = objSubstantivo.classificaSubstantivo(frase, posicao: 2)
            }
        }
            
        else if (frase[2].categories[0].text == "pronome"){
            
     /**********     IRÁ COLOCAR ARTIGO CASO NÃO TENHA PREPOSIÇÃO QUANDO FOR PRONOME   **********/
            
            pronomeTonico.append(objPronome.transformaEmPronomeObliquosTonico(frase))
            if (preposicao == "null"){
                arrayArtigos = objPronome.categorizarPronome(frase, posicao: 2)
            }
            
            arrayArtigos.append(pronomeTonico[0] + ".")
            pronomeTonico.removeAll()
            return arrayArtigos
        }
        else if (frase[2].categories[0].text == "verbo")
        {
            if (preposicao != "null") && (preposicao == "gerundio"){
                arrayArtigos.append(translator.buscaVerbo(frase[2].text, sujeito: frase[0].text, flexao: "infinitivo", categoria: "verbo"))
            }
        }
        
        arrayArtigos.append(frase[2].text + ".")
        return arrayArtigos
    }
}