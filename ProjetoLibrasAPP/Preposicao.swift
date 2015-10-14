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
    
    /**********     VARIÁVEIS    **********/

    var palavra: [String] = []
    var objArtigo = Artigo()
    var colocaArtigo : [String] = []
    var colocaPreposicao : String = ""
    let path = NSBundle.mainBundle().pathForResource("Preposicao", ofType: "plist")
    var dict = NSDictionary!()
    let pathPronome = NSBundle.mainBundle().pathForResource("PronomesPessoais", ofType: "plist")
    var dictPronome = NSDictionary!()
    
    override init(){
        super.init()
        dict = NSDictionary(contentsOfFile: path!)
        dictPronome = NSDictionary(contentsOfFile: pathPronome!)
    }
    
    /**********     FUNÇÃO QUE VERIFICA SE O VERBO TEM PREPOSIÇÃO    **********/
    
    func inserePreposicao(texto : [Word]) -> String {
        colocaPreposicao.removeAll()
        
    /**********     CHAMA FUNÇÃO QUE VERIFICA SE JÁ ESTA TRATADO    **********/
        
        if (!verificaVerboNaLista(texto, dict: self.dict, posicao: 1)){
            colocaPreposicao = ""
        }
        
        else {
            
            let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[0].text)?.valueForKey(texto[2].flexions[0].text) as AnyObject? as! String
            
            if (texto[1].text == "estar") || (texto[1].text == "poder") && (texto[2].text == "casa"){
                colocaPreposicao = "em"
            }
            
    /**********     ALTERAR PARA TRATAMENTO DE PRONOMES OBLIQUOS/ FUNCIONA SÓ COM O VERBO IR    **********/
                
            else if (texto[1].text == "ir") {
                if (!verificaVerboNaLista(texto, dict : self.dictPronome, posicao : 2)) && (texto[2].categories[0].text == "pronome"){
                    colocaArtigo = objArtigo.colocarArtigoDefinido(texto, posicao: 2)
                    if(colocaArtigo[0] != ""){
                        colocaPreposicao = test + " " + colocaArtigo[0]
                    }
                    else{
                        colocaPreposicao = test + colocaArtigo[0]
                    }
                }
                else if (verificaVerboNaLista(texto, dict : self.dictPronome, posicao : 2)) {
                    colocaPreposicao = ""
                }
                else{
                    colocaPreposicao = test
                }
            }
            else{
                colocaPreposicao = test
            }
        }
    
        return colocaPreposicao
    }
    
    
    /**********     VERIFICA SE EXISTE NA PLIST   **********/

    func verificaVerboNaLista(frase : [Word], dict : NSDictionary, posicao : Int) -> Bool {
        for (var i = 0; i <= (dict.allKeys.count) - 1 ; i++){
            if ((dict.allKeys[i]) as! String == frase[posicao].text) {
                return true
            }
        }
        return false
    }
 
}