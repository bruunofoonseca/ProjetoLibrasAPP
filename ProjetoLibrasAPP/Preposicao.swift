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
        print(posicao)
        var posPronome = -1
        var posVerbo = -1
        var posVerboConfere = -1
        var posSubstantivo = -1
        posPronomeFlexion = posPronome
        
        pronomeTonico.append(objPronome.transformaEmPronomeObliquosTonico(texto, posicao: posicao))

        
        for (var i = 0; i < texto[2].categories.count; i++){
            if (texto[2].categories[i].text == "pronome"){
                posPronome = i
                posPronomeFlexion = i
            }
            if (texto[2].categories[i].text == "verbo"){
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
        
        if (posVerbo == -1){
            posVerboConfere = posVerbo
            posVerbo = 0
        }
        else{
            posVerboConfere = posVerbo
        }
    
        if (!verificaVerboNaLista(texto, dict: self.dict, posicao: 1)){
            if(texto[2].categories[posVerbo].text == "verbo") && (texto[1].categories[posicao].text == "verbo"){
                colocaPreposicao = "e"
            }
            else{
                colocaPreposicao = ""
            }
        }
        else if (texto[2].categories[posPronome].text == "pronome") && (pronomeTonico[0] != texto[2].text){
            
            var posPronomeFlexion = (texto[2].flexions.count - 1)
            
            while(texto[2].flexions[posPronomeFlexion].text != "Feminino singular" && texto[2].flexions[posPronomeFlexion].text != "Masculino singular" && texto[2].flexions[posPronomeFlexion].text != "Masculino plural" && texto[2].flexions[posPronomeFlexion].text != "Feminino plural"){
                posPronomeFlexion = posPronomeFlexion - 1
            }
            
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
        else if(texto[2].categories[posPronome].text == "pronome") && (pronomeTonico[0] == texto[2].text){
            var posPronomeFlexion = (texto[2].flexions.count - 1)
            
            while(texto[2].flexions[posPronomeFlexion].text != "Feminino singular" && texto[2].flexions[posPronomeFlexion].text != "Masculino singular" && texto[2].flexions[posPronomeFlexion].text != "Masculino plural" && texto[2].flexions[posPronomeFlexion].text != "Feminino plural"){
                posPronomeFlexion = posPronomeFlexion - 1
            }
            
            let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[posPronome].text)?.valueForKey(texto[2].flexions[posPronomeFlexion].text) as AnyObject? as! String
            
            colocaPreposicao = test
            
        }
        else {
            
            var posSubstantivoFlexion = (texto[2].flexions.count - 1)
            var posVerboFlexion = (texto[2].flexions.count - 1)

            if (posVerboConfere != -1){
                
                while(texto[2].flexions[posVerboFlexion].text != "Infinitivo"){
                    posVerboFlexion = posVerboFlexion - 1
                }
                
                let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[posVerbo].text)?.valueForKey(texto[2].flexions[posVerboFlexion].text) as AnyObject? as! String
                
                colocaPreposicao = test
            }
            else if (posSubstantivo != -1){
                if (texto[2].categories[posSubstantivo].text == "nome feminino"){
                    while (texto[2].flexions[posSubstantivoFlexion].text != "Feminino singular" && texto[2].flexions[posSubstantivoFlexion].text != "sing" && texto[2].flexions[posSubstantivoFlexion].text != "plur" && texto[2].flexions[posSubstantivoFlexion].text != "Feminino plural"){
                        posSubstantivoFlexion = posSubstantivoFlexion - 1
                    }
                }
                else if (texto[2].categories[posSubstantivo].text == "nome masculino"){
                    
                    while (texto[2].flexions[posSubstantivoFlexion].text != "sing" && texto[2].flexions[posSubstantivoFlexion].text != "plur" && texto[2].flexions[posSubstantivoFlexion].text != "Masculino plural" && texto[2].flexions[posSubstantivoFlexion].text != "Masculino singular"){
                        posSubstantivoFlexion = posSubstantivoFlexion - 1
                    
                    }
            
                }
                
                let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].categories[posSubstantivo].text)?.valueForKey(texto[2].flexions[posSubstantivoFlexion].text) as AnyObject? as! String
                
                colocaPreposicao = test
            }
            
            
            if (texto[1].text == "estar") || (texto[1].text == "poder") || (texto[1].text == "estudar") && (texto[2].text == "casa"){
                colocaPreposicao = "em"
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