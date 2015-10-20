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
    var posPronomeFlexion : Int!
    
    override init(){
        super.init()
        dict = NSDictionary(contentsOfFile: path!)
        dictPronome = NSDictionary(contentsOfFile: pathPronome!)
    }
    
    /**********     FUNÇÃO QUE VERIFICA SE O VERBO TEM PREPOSIÇÃO    **********/
    
    func inserePreposicao(texto : [Word], var posicao: Int) -> String {
        colocaPreposicao.removeAll()
        pronomeTonico.removeAll()
        pronomeTonico.append(objPronome.transformaEmPronomeObliquosTonico(texto))
        
        var posPronome = -1
        var posVerbo = -1
        var posSubstantivo = -1
        posPronomeFlexion = posPronome
        
        for (var i = 0; i < texto[2].categories.count; i++){
            if (texto[2].categories[i].text == "pronome"){
                posPronome = i
                posPronomeFlexion = i
            }
            if (texto[2].categories[i].text == "verbo") && (texto[2].flexions[i].text == "Infinitivo Flexionado - 1ª singular"){
                posVerbo = i
            }
            else if (texto[2].categories[i].text == "nome feminino" || texto[2].categories[i].text == "nome masculino" ) && (posSubstantivo == -1){
                posSubstantivo = i
            }
        }
        
    /**********     CHAMA FUNÇÃO QUE VERIFICA SE JÁ ESTA TRATADO    **********/
        if(posicao == -1){
            posicao = 0
        }
        
        if (posPronome == -1){
            posPronome = 0
        }
        
        if (!verificaVerboNaLista(texto, dict: self.dict, posicao: 1)){
            if(texto[2].categories[posVerbo].text == "verbo") && (texto[1].categories[posicao].text == "verbo") && (texto[1].flexions[posicao].text == "Infinitivo Flexionado - 1ª singular") && (texto[2].flexions[posVerbo].text == "Infinitivo Flexionado - 1ª singular"){
                colocaPreposicao = "e"
            }
            else{
                colocaPreposicao = ""
            }
        }
        else if (texto[2].categories[posPronome].text == "pronome") && (pronomeTonico[0] != texto[2].text){
            
            let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[posPronome].text)?.valueForKey(texto[2].flexions[posPronomeFlexion].text) as AnyObject? as! String
            
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
        else if(texto[2].categories[0].text == "adjetivo"){
            for(var i = 0; i < texto[2].flexions.count; i++){
                if (texto[2].categories[i].text == "nome feminino") || (texto[2].flexions[i].text == "nome masculino") {
                    
                    let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[i].text)?.valueForKey(texto[2].flexions[i].text) as AnyObject? as! String
                    
                    colocaPreposicao = test
                }
                else{
                    colocaPreposicao = ""
                }
            }
        }
        else {
            
            var gravaPosicaoCategoria = -1;
            var gravaPosicaoFlexion = -1;
            
            if (posPronome != -1){
                gravaPosicaoCategoria = posPronome
                gravaPosicaoFlexion = posPronomeFlexion
    
            }
            else if(posSubstantivo != -1){
                gravaPosicaoFlexion = posSubstantivo
                gravaPosicaoFlexion = posSubstantivo
            }
            
            if (posPronome != -1){
                for (var j = texto[2].flexions.count - 1; j >= 0; j--){
                    if(texto[2].flexions[j].text == "Masculino singular") || (texto[2].flexions[j].text == "Feminino singular"){
                        gravaPosicaoFlexion = j
                    }
                }
            }
           
            let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[gravaPosicaoCategoria].text)?.valueForKey(texto[2].flexions[gravaPosicaoFlexion].text) as AnyObject? as! String
            
            if (texto[1].text == "estar") || (texto[1].text == "poder") || (texto[1].text == "estudar") && (texto[2].text == "casa"){
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