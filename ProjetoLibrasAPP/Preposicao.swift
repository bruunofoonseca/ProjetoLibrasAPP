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
    var objPronome = Pronome()
    var pronomeTonico : [String] = []
    var colocaArtigo : [String] = []
    var colocaPreposicao : String = ""
    let path = NSBundle.mainBundle().pathForResource("Preposicao", ofType: "plist")
    var dict = NSDictionary!()
    let pathPronome = NSBundle.mainBundle().pathForResource("PronomeObliquosEu", ofType: "plist")
    var dictPronome = NSDictionary!()
    
    override init(){
        super.init()
        dict = NSDictionary(contentsOfFile: path!)
        dictPronome = NSDictionary(contentsOfFile: pathPronome!)
    }
    
    /**********     FUNÇÃO QUE VERIFICA SE O VERBO TEM PREPOSIÇÃO    **********/
    
    func inserePreposicao(texto : [Word]) -> String {
        colocaPreposicao.removeAll()
        pronomeTonico.removeAll()
        pronomeTonico.append(objPronome.transformaEmPronomeObliquosTonico(texto))
        
    /**********     CHAMA FUNÇÃO QUE VERIFICA SE JÁ ESTA TRATADO    **********/
        
        if(texto[2].text == "gostar")&&(texto[1].text == "nadar"){
            colocaPreposicao = "por"
        }
        
        if (!verificaVerboNaLista(texto, dict: self.dict, posicao: 1)){
            if(texto[2].categories[0].text == "verbo") && (texto[1].categories[0].text == "verbo"){
                colocaPreposicao = "e"
            }
            else{
                colocaPreposicao = ""
            }
        }
        else if (texto[2].categories[0].text == "pronome") && (pronomeTonico[0] != texto[2].text){
            
            let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[0].text)?.valueForKey(texto[2].flexions[0].text) as AnyObject? as! String
            
            colocaPreposicao = test
            
            if (verificaVerboNaLista(texto, dict: dictPronome, posicao: 1)){
                if (pronomeTonico[0] == "dele") || (pronomeTonico[0] == "dela" || (pronomeTonico[0] == "deles") || (pronomeTonico[0] == "delas") || (pronomeTonico[0] == "nele") || (pronomeTonico[0] == "nela") || (pronomeTonico[0] == "neles") || (pronomeTonico[0] == "nelas")){
                    colocaPreposicao = ""
                }
            }
            else if(!verificaVerboNaLista(texto, dict: dictPronome, posicao: 1)){
                if (texto[2].text != pronomeTonico[0]){
                    colocaPreposicao = ""
                }
            }
        }
        else {
            
            let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[0].text)?.valueForKey(texto[2].flexions[0].text) as AnyObject? as! String
            
            if (texto[1].text == "nadar") || (texto[1].text == "estar") || (texto[1].text == "poder") || (texto[1].text == "estudar") && (texto[2].text == "casa"){
                colocaPreposicao = "em"
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