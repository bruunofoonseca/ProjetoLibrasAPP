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
    let path = NSBundle.mainBundle().pathForResource("PronomesPessoais", ofType: "plist")
    var dict = NSDictionary!()
    
    override init(){
        dict = NSDictionary(contentsOfFile: path!)
        super.init()
    }
    
    
    /**********     FUNÇÃO QUE TRATA O PRONOME DE ACORDO COM SUA PARTICULARIDADE   **********/

    func categorizarPronome(frase : [Word], posicao : Int) -> [String]{
        recebeArtigo.removeAll()
        if (frase[posicao].categories[0].text == "pronome"){
            if (frase[posicao].text == "eu") || (frase[posicao].text == "tu") || (frase[posicao].text == "ele") || (frase[posicao].text == "nós") || (frase[posicao].text == "vós") || (frase[posicao].text == "eles") || (frase[posicao].text == "ela") || (frase[posicao].text == "elas"){
                recebeArtigo = objArtigo.colocarArtigoDefinido(frase, posicao: posicao)
            }
            else if (frase[posicao].text == "senhor" || frase[posicao].text == "senhora" || frase[posicao].text == "senhorita")
            {
                recebeArtigo = objArtigo.colocarArtigoDefinido(frase, posicao: posicao)
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
            if(verificaVerboNaLista(frase, dict: self.dict, posicao: 1)){
                if(frase[2].text == "eu"){
                    pronomeTransformado = "mim"
                }
                else if (frase[2].text == "tu"){
                    pronomeTransformado = "ti"
                }
                else if (frase[2].text == "ele")&&(frase[1].text != "ter"){
                    if(frase[1].text == "pensar"){
                        pronomeTransformado = "nele"
                    }
                    else{
                        pronomeTransformado = "dele"
                    }
                }
                else if (frase[2].text == "ela")&&(frase[1].text != "ter")&&(frase[1].text != "dar"){
                    if(frase[1].text == "pensar"){
                        pronomeTransformado = "nela"
                    }
                    else{
                        pronomeTransformado = "dela"
                    }
                }
                else if (frase[2].text == "eles")&&(frase[1].text != "ter")&&(frase[1].text != "dar"){
                    if(frase[1].text == "pensar"){
                        pronomeTransformado = "neles"
                    }
                    else{
                        pronomeTransformado = "deles"
                    }
                }
                else if (frase[2].text == "elas")&&(frase[1].text != "ter")&&(frase[1].text != "dar"){
                    if(frase[1].text == "pensar"){
                        pronomeTransformado = "nelas"
                    }
                    else{
                        pronomeTransformado = "delas"
                    }
                }
            }
            else if (!verificaVerboNaLista(frase, dict: self.dict, posicao: 1)) && (frase[1].text != "ser") {
                if(frase[2].text == "eu"){
                    pronomeTransformado = "comigo"
                }
                if(frase[2].text == "nós"){
                    pronomeTransformado = "conosco"
                }
                if(frase[2].text == "tu"){
                    pronomeTransformado = "contigo"
                }
                if(frase[2].text == "vós"){
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