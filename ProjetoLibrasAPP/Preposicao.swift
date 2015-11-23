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
    let pathPronomeExcecao = NSBundle.mainBundle().pathForResource("PreposicaoExcecao", ofType: "plist")
    var dictPronome = NSDictionary!()
    var dictPronomeExcecao = NSDictionary!()
    var posPronomeFlexion : Int!
    var preposicaoExcecao: String!
    var posicaoMotto = 0
    var posicaoMottoVerbo = 0
    
    override init(){
        super.init()
        dict = NSDictionary(contentsOfFile: path!)
        dictPronome = NSDictionary(contentsOfFile: pathPronome!)
        dictPronomeExcecao = NSDictionary(contentsOfFile: pathPronomeExcecao!)
    }
    
    /**********     FUNÇÃO QUE VERIFICA SE O VERBO TEM PREPOSIÇÃO    **********/
    
    func inserePreposicao(texto : [Word], var posicao: Int) -> String {
        colocaPreposicao.removeAll()
        pronomeTonico.removeAll()
        var posPronome = -1
        var posVerbo = -1
        var posVerboConfere = -1
        var posSubstantivo = -1
        posPronomeFlexion = posPronome
        
        pronomeTonico.append(objPronome.transformaEmPronomeObliquosTonico(texto, posicao: posicao))
        
        for(var i = 0; i < texto[2].mottos.count; i++){
            if (texto[2].text == texto[2].mottos[i].text){
                posicaoMotto = i
            }
        }
        
        for(var i = 0; i < texto[1].mottos.count; i++){
            if (texto[1].text == texto[1].mottos[i].text){
                posicaoMottoVerbo = i
            }
        }
        
        for (var i = 0; i < texto[2].mottos[posicaoMotto].categories.count; i++){
            if (texto[2].mottos[posicaoMotto].categories[i].text == "pronome"){
                posPronome = i
                posPronomeFlexion = i
            }
            if (texto[2].mottos[posicaoMotto].categories[i].text == "verbo"){
                for (var j = 0; j < texto[2].flexions.count; j++){
                    if (texto[2].flexions[j].text == "Infinitivo Flexionado - 1ª singular"){
                        posVerbo = i
                    }
                }
            }
            else if (texto[2].mottos[posicaoMotto].categories[i].text == "nome feminino" || texto[2].mottos[posicaoMotto].categories[i].text == "nome masculino" ) && (posSubstantivo == -1){
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
        
        print(texto[1].mottos[posicaoMottoVerbo].text)
        
        if (!verificaVerboNaLista(texto, dict: self.dict, posicao: 1)){
            if(texto[2].mottos[posicaoMotto].categories[posVerbo].text == "verbo"){
                colocaPreposicao = "e"
            }
            else{
                colocaPreposicao = ""
            }
        }
        else if (texto[2].mottos[posicaoMotto].categories[posPronome].text == "pronome") && (pronomeTonico[0] != texto[2].text){
            
            var posPronomeFlexion = (texto[2].flexions.count - 1)
            
            while(texto[2].flexions[posPronomeFlexion].text != "Feminino singular" && texto[2].flexions[posPronomeFlexion].text != "Masculino singular" && texto[2].flexions[posPronomeFlexion].text != "Masculino plural" && texto[2].flexions[posPronomeFlexion].text != "Feminino plural"){
                posPronomeFlexion = posPronomeFlexion - 1
            }
            
            let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].mottos[posicaoMotto].categories[posPronome].text)?.valueForKey(texto[2].flexions[posPronomeFlexion].text) as AnyObject? as! String
            
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
        else if(texto[2].mottos[posicaoMotto].categories[posPronome].text == "pronome") && (pronomeTonico[0] == texto[2].text){
            var posPronomeFlexion = (texto[2].flexions.count - 1)
            
            while(texto[2].flexions[posPronomeFlexion].text != "Feminino singular" && texto[2].flexions[posPronomeFlexion].text != "Masculino singular" && texto[2].flexions[posPronomeFlexion].text != "Masculino plural" && texto[2].flexions[posPronomeFlexion].text != "Feminino plural"){
                posPronomeFlexion = posPronomeFlexion - 1
            }
            
            let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].mottos[posicaoMotto].categories[posPronome].text)?.valueForKey(texto[2].flexions[posPronomeFlexion].text) as AnyObject? as! String
            
            colocaPreposicao = test
            
        }
        else if (texto[2].mottos[posicaoMotto].categories[posVerbo].text == "verbo")  {
            
            var posVerboFlexion = (texto[2].flexions.count - 1)
            
            if (posVerboConfere != -1){
                
                while(texto[2].flexions[posVerboFlexion].text != "Infinitivo"){
                    posVerboFlexion = posVerboFlexion - 1
                }
                
                if(verificaExcecao(texto, dict: dictPronomeExcecao, posicao: 1)){
                    let test = dictPronomeExcecao!.objectForKey(texto[1].text)?.valueForKey(texto[2].text) as AnyObject? as! String
                    colocaPreposicao = test
                }
                else{
                    
                    let test = dict!.objectForKey(texto[1].text)?.objectForKey(texto[2].mottos[posicaoMotto].categories[posVerbo].text)?.valueForKey(texto[2].flexions[posVerboFlexion].text) as AnyObject? as! String
                    
                    colocaPreposicao = test
                }
            }
        }
        else if (posSubstantivo != -1){
            var posSubstantivoFlexion = (texto[2].flexions.count - 1)
            
            if (texto[2].mottos[posicaoMotto].categories[posSubstantivo].text == "nome feminino"){
                
                while (texto[2].flexions[posSubstantivoFlexion].text != "Feminino singular" && texto[2].flexions[posSubstantivoFlexion].text != "sing" && texto[2].flexions[posSubstantivoFlexion].text != "plur" && texto[2].flexions[posSubstantivoFlexion].text != "Feminino plural"){
                    posSubstantivoFlexion = posSubstantivoFlexion - 1
                }
            }
            else if (texto[2].mottos[posicaoMotto].categories[posSubstantivo].text == "nome masculino"){
                
                while (texto[2].flexions[posSubstantivoFlexion].text != "sing" && texto[2].flexions[posSubstantivoFlexion].text != "plur" && texto[2].flexions[posSubstantivoFlexion].text != "Masculino plural" && texto[2].flexions[posSubstantivoFlexion].text != "Masculino singular"){
                    posSubstantivoFlexion = posSubstantivoFlexion - 1
                    
                }
                
            }
            
            if(verificaExcecao(texto, dict: dictPronomeExcecao, posicao: 1)){
                let test = dictPronomeExcecao!.objectForKey(texto[1].text)?.valueForKey(texto[2].text) as AnyObject? as! String
                colocaPreposicao = test
            }
            else{
                let test = dict!.objectForKey(texto[1].mottos[posicaoMottoVerbo].text)?.objectForKey(texto[2].mottos[posicaoMotto].categories[posSubstantivo].text)?.valueForKey(texto[2].flexions[posSubstantivoFlexion].text) as AnyObject? as! String
                
                colocaPreposicao = test
            }
        }
        
        if (texto[1].text == "estar") || (texto[1].text == "poder") || (texto[1].text == "estudar") && (texto[2].text == "casa"){
            colocaPreposicao = "em"
        }
        
        return colocaPreposicao
    }
    
    /**********     VERIFICA SE EXISTE NA PLIST   **********/
    
    func verificaVerboNaLista(frase : [Word], dict : NSDictionary, posicao : Int) -> Bool {
        for (var i = 0; i <= (dict.allKeys.count) - 1 ; i++){
            if ((dict.allKeys[i]) as! String == frase[posicao].mottos[self.posicaoMottoVerbo].text) {
                return true
            }
        }
        return false
    }
    
    func verificaExcecao (frase : [Word], dict : NSDictionary, posicao: Int) -> Bool{
        for (var i = 0; i <= (dict.allKeys.count) - 1 ; i++){
            
            if ((dict.allKeys[i]) as! String == frase[posicao].mottos[posicaoMottoVerbo].text){
                for (var j = 0; j < dict.objectForKey(frase[posicao].mottos[posicaoMottoVerbo].text)?.allKeys.count; j++){
                    let teste = dict.objectForKey(frase[posicao].mottos[posicaoMottoVerbo].text)?.allKeys[j] as! String
                    if (teste == frase[2].mottos[posicaoMotto].text){
                        preposicaoExcecao = teste
                        return true
                    }
                }
            }
        }
        
        return false
    }
}