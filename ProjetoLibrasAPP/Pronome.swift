//
//  Pronome.swift
//  ProjetoLibrasAPP
//
//  Created by Bruno F. de Almeida on 01/10/15.
//  Copyright © 2015 BEPiD. All rights reserved.
//

import Foundation
import UIKit

class Pronome: NSObject {
    
    /**********     VARIÁVEIS    **********/

    var recebeArtigo : [String] = []
    var objArtigo = Artigo()
    let pathPronomeEu = NSBundle.mainBundle().pathForResource("PronomeObliquosEu", ofType: "plist")
    var dictPronomeEu = NSDictionary!()
    let pathPronomeEle = NSBundle.mainBundle().pathForResource("PronomeObliquosEle", ofType: "plist")
    var dictPronomeEle = NSDictionary!()
    
    override init(){
        dictPronomeEu = NSDictionary(contentsOfFile: pathPronomeEu!)
        dictPronomeEle = NSDictionary(contentsOfFile: pathPronomeEle!)
        super.init()
    }
    
    
    /**********     FUNÇÃO QUE TRATA O PRONOME DE ACORDO COM SUA PARTICULARIDADE   **********/

    func categorizarPronome(frase : [Word], posicao : Int, posCategoria : Int, posFlexion : Int) -> [String]{
        recebeArtigo.removeAll()
        if (frase[posicao].categories[posCategoria].text == "pronome"){
            if (frase[posicao].text == "eu") || (frase[posicao].text == "tu") || (frase[posicao].text == "ele") || (frase[posicao].text == "nós") || (frase[posicao].text == "vós") || (frase[posicao].text == "eles") || (frase[posicao].text == "ela") || (frase[posicao].text == "elas"){
                recebeArtigo.append("")
            }
            else if (frase[posicao].text == "senhor" || frase[posicao].text == "senhora" || frase[posicao].text == "senhorita")
            {
                recebeArtigo = objArtigo.colocarArtigoDefinido(frase, posicao: posicao, posCategoria: posCategoria, posFlexion : posFlexion)
            }
            else
            {
                recebeArtigo.append("")
            }
        }
        
        return recebeArtigo
    }
    
    /**********     TRANSFORMA EM PRONOME OBLIQUO CASO NECESSÁRIO   **********/
    
    func transformaEmPronomeObliquosTonico (frase : [Word]) -> String{
        
        var pronomeTransformado = frase[2].text
        
        if(frase[1].categories[0].text == "verbo"){
            
            if(frase[2].text == "eu") && (frase[1].text != "ser"){
                if(verificaVerboNaLista(frase, dict: dictPronomeEu, posicao: 1)){
                    pronomeTransformado = "mim"
                }
                else{
                    pronomeTransformado = "comigo"
                }
            }
            else if (frase[2].text == "tu"){
                if(verificaVerboNaLista(frase, dict: dictPronomeEu, posicao: 1)){
                    pronomeTransformado = "ti"
                }
                else{
                    pronomeTransformado = "contigo"
                }
            }
            else if (frase[2].text == "ele") || (frase[2].text == "ela") || (frase[2].text == "eles") || (frase[2].text == "elas") {
                
                if(verificaVerboNaLista(frase, dict: dictPronomeEle, posicao: 1)){
                    
                    pronomeTransformado = dictPronomeEle!.objectForKey(frase[1].text)?.valueForKey(frase[2].text) as AnyObject? as! String
                }
            }
            else if (frase[2].text == "nós"){
                if(!verificaVerboNaLista(frase, dict: dictPronomeEu, posicao: 1)){
                    pronomeTransformado = "conosco"
                }
            }
            else if (frase[2].text == "vós"){
                if(!verificaVerboNaLista(frase, dict: dictPronomeEu, posicao: 1)){
                    pronomeTransformado = "convosco"
                }
            }
        }
        return pronomeTransformado
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